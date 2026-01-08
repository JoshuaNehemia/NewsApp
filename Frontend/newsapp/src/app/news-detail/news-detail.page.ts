import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { HttpService } from '../http-service';
import { ToastController } from '@ionic/angular';

@Component({
  selector: 'app-news-detail',
  templateUrl: './news-detail.page.html',
  styleUrls: ['./news-detail.page.scss'],
  standalone: false,
})
export class NewsDetailPage implements OnInit {
  article: any = null;
  selectedImage: string = '';
  userRating: number = 0;
  newComment: string = '';

  constructor(
    private route: ActivatedRoute,
    private http: HttpService,
    private toastCtrl: ToastController
  ) {}

  ngOnInit() {
    // Ambil ID dari URL (misal: /news-detail/1)
    const newsId = this.route.snapshot.paramMap.get('id');
    if (newsId) {
      this.loadNewsDetail(+newsId);
      this.addViewCount(+newsId);
    }
  }
  loadNewsDetail(id: number) {
    this.http.get_news_detail(id).subscribe(
      (res: any) => {
        if (res.status === 'success') {
          const data = res.data;

          this.article = {
            id: data.id,
            title: data.title,
            mainImage:
              data.images && data.images.length > 0
                ? data.images[0]
                : 'assets/images/placeholder.jpg',
            images: data.images || [],
            categories: [data.category],
            author: data.author.fullname,
            date: data.created_at,
            content: data.content,
            view_count: data.view_count || 0,
            like_count: data.like_count || 0,
            comment_count: data.comment_count || 0,
            tags: data.tags || [],
            comments: data.comments || [],

            rating: data.rating,
            isFavorite: false,
          };

          this.selectedImage = this.article.mainImage;
        } else {
          this.showToast('Gagal memuat berita', 'danger');
        }
      },
      (err) => {
        console.error(err);
      }
    );
  }
  addViewCount(id: number) {
    this.http.add_view(id).subscribe();
  }

  likeNews() {
    if (!this.article) return;
    this.http.like_news(this.article.id).subscribe(
      (res: any) => {
        this.article.like_count++;
        this.article.isFavorite = true;
        this.showToast('Berita disukai!', 'success');
      },
      (err) => {
        console.error('Gagal like', err);
      }
    );
  }

  selectImage(img: string) {
    this.selectedImage = img;
  }

  rateNews(star: number) {
    this.userRating = star;
    // Nanti bisa panggil API add_rating.php disini
    this.showToast(`Anda memberi rating ${star} bintang`, 'primary');
  }

  addComment() {
    if (!this.newComment.trim()) return;
    const mockComment = {
      user: { name: 'Saya' }, // Ganti dengan user login
      text: this.newComment,
    };

    if (!this.article.comments) this.article.comments = [];
    this.article.comments.push(mockComment);

    this.newComment = '';
    this.showToast('Komentar terkirim', 'success');
  }

  async showToast(msg: string, color: string) {
    const toast = await this.toastCtrl.create({
      message: msg,
      duration: 2000,
      color: color,
      position: 'bottom',
    });
    toast.present();
  }
}

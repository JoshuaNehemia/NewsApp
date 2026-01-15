import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
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
  replyingTo: number | null = null;
  replyText: string = '';
  currentUser: any = {};

  constructor(
    private route: ActivatedRoute,
    private router: Router,
    private http: HttpService,
    private toastCtrl: ToastController
  ) { }

  ngOnInit() {
    const userStr = localStorage.getItem('user_data');
    if (userStr) {
      this.currentUser = JSON.parse(userStr);
    }
    const newsId = this.route.snapshot.paramMap.get('id');
    if (newsId) {
      this.loadNewsDetail(+newsId);
      this.addViewCount(+newsId);
    }
  }
  loadNewsDetail(id: number, username: string = '') {
    const user =
      username ||
      (this.currentUser && this.currentUser.username
        ? this.currentUser.username
        : '');
    this.http.get_news_detail(id, user).subscribe(
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
            categories: data.categories && data.categories.length > 0 ? data.categories : (data.category ? [data.category] : []),
            author: data.author.fullname,
            author_username: data.author.username,
            date: data.created_at,
            content: data.content,
            user_status: Number(data.user_status || 0),
            dislike_count: Number(data.dislike_count || 0),
            view_count: data.view_count || 0,
            like_count: Number(data.like_count || 0),
            comment_count: data.comment_count || 0,
            tags: data.tags || [],
            comments: data.comments || [],
            rating: data.avg_rating || 0,
            rating_count: data.rating_count || 0,
            isFavorite: false,
          };

          this.selectedImage = this.article.mainImage;

          // Set user's rating if available
          if (data.user_rating !== null && data.user_rating !== undefined) {
            this.userRating = Math.round(data.user_rating);
          }

          // Load comments
          this.loadComments();
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

  selectImage(img: string) {
    this.selectedImage = img;
  }

  rateNews(star: number) {
    if (!this.article || !this.currentUser.username) {
      this.showToast('Silahkan login terlebih dahulu', 'warning');
      return;
    }

    this.http.add_rating(this.article.id, this.currentUser.username, star).subscribe(
      (res: any) => {
        if (res.status === 'success') {
          this.userRating = star;
          this.article.rating = res.data.avg_rating;
          this.showToast(`Anda memberi rating ${star} bintang`, 'success');
        }
      },
      (err) => {
        console.error('Gagal memberi rating', err);
        this.showToast('Gagal memberi rating', 'danger');
      }
    );
  }

  addComment() {
    if (!this.newComment.trim()) return;

    if (!this.article || !this.currentUser.username) {
      this.showToast('Silahkan login terlebih dahulu', 'warning');
      return;
    }

    this.http.add_comment(this.article.id, this.currentUser.username, this.newComment).subscribe(
      (res: any) => {
        if (res.status === 'success') {
          this.newComment = '';
          this.showToast('Komentar terkirim', 'success');
          // Reload comments
          this.loadComments();
          this.article.comment_count++;
        }
      },
      (err) => {
        console.error('Gagal mengirim komentar', err);
        this.showToast('Gagal mengirim komentar', 'danger');
      }
    );
  }

  loadComments() {
    if (!this.article) return;

    this.http.get_comments(this.article.id).subscribe(
      (res: any) => {
        if (res.status === 'success' && res.data) {
          // Build hierarchical structure
          const commentsMap = new Map();
          const topLevelComments: any[] = [];

          // First pass: create all comment objects
          res.data.forEach((comment: any) => {
            const commentObj = {
              id: comment.id,
              username: comment.username,
              user: { name: comment.fullname || comment.username },
              text: comment.content,
              date: comment.created_at,
              reply_to_id: comment.reply_to_id,
              replies: []
            };
            commentsMap.set(comment.id, commentObj);
          });

          // Second pass: build hierarchy
          commentsMap.forEach((comment) => {
            if (comment.reply_to_id) {
              // This is a reply, add to parent's replies array
              const parent = commentsMap.get(comment.reply_to_id);
              if (parent) {
                parent.replies.push(comment);
              }
            } else {
              // This is a top-level comment
              topLevelComments.push(comment);
            }
          });

          this.article.comments = topLevelComments;
          this.article.comment_count = res.count || commentsMap.size;
        } else {
          this.article.comments = [];
        }
      },
      (err) => {
        console.error('Gagal memuat komentar', err);
        // Don't fail page, just set empty
        if (this.article) {
          this.article.comments = [];
        }
      }
    );
  }

  toggleReply(commentId: number) {
    if (this.replyingTo === commentId) {
      this.replyingTo = null;
      this.replyText = '';
    } else {
      this.replyingTo = commentId;
      this.replyText = '';
    }
  }

  addReply(commentId: number) {
    if (!this.replyText.trim()) return;

    if (!this.article || !this.currentUser.username) {
      this.showToast('Silahkan login terlebih dahulu', 'warning');
      return;
    }

    this.http.add_comment(this.article.id, this.currentUser.username, this.replyText, commentId).subscribe(
      (res: any) => {
        if (res.status === 'success') {
          this.replyText = '';
          this.replyingTo = null;
          this.showToast('Balasan terkirim', 'success');
          // Reload comments
          this.loadComments();
        }
      },
      (err) => {
        console.error('Gagal mengirim balasan', err);
        this.showToast('Gagal mengirim balasan', 'danger');
      }
    );
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

  toggleLike() {
    if (!this.article || !this.currentUser.username) {
      this.showToast('Silahkan login terlebih dahulu', 'warning');
      return;
    }

    this.http.like_news(this.article.id, this.currentUser.username).subscribe(
      (res: any) => {
        if (res.status === 'success') {
          this.article.user_status = Number(res.data.user_status);
          if (res.data.stats) {
            this.article.like_count = Number(res.data.stats.like_count || 0);
            this.article.dislike_count = Number(
              res.data.stats.dislike_count || 0
            );
          }

          const msg =
            this.article.user_status === 1
              ? 'Berita disukai.'
              : 'Like dibatalkan.';
          this.showToast(msg, 'success');

          // Emit event to refresh favorites list
          this.http.emitFavoritesChanged({
            newsId: this.article.id,
            isLiked: this.article.user_status === 1
          });
        }
      },
      (err) => {
        console.error('Gagal like', err);
        this.showToast('Writter tidak bisa melakukan aksi tersebut', 'danger');
      }
    );
  }

  toggleDislike() {
    if (!this.article || !this.currentUser.username) {
      this.showToast('Silahkan login terlebih dahulu', 'warning');
      return;
    }

    this.http
      .dislike_news(this.article.id, this.currentUser.username)
      .subscribe(
        (res: any) => {
          if (res.status === 'success') {
            this.article.user_status = Number(res.data.user_status);
            if (res.data.stats) {
              this.article.like_count = Number(res.data.stats.like_count || 0);
              this.article.dislike_count = Number(
                res.data.stats.dislike_count || 0
              );
            }
            const msg =
              this.article.user_status === 0
                ? 'Berita di-dislike.'
                : 'Dislike dibatalkan.';
            this.showToast(msg, 'primary');
          }
        },
        (err) => {
          console.error('Gagal dislike', err);
          this.showToast('Writter tidak bisa melakukan aksi tersebut', 'danger');
        }
      );
  }

  deleteNews() {
    console.log('Delete clicked. CurrentUser:', this.currentUser);
    console.log('Article Author:', this.article?.author_username);
    
    if (!this.article || !this.currentUser.username) {
      this.showToast('Silahkan login terlebih dahulu', 'warning');
      return;
    }

    // Verify current user is the author
    if (this.currentUser.username !== this.article.author_username) {
      console.log('Not author. Current:', this.currentUser.username, 'Author:', this.article.author_username);
      this.showToast('Anda tidak memiliki izin menghapus berita ini', 'danger');
      return;
    }

    // Confirm deletion
    const confirmed = window.confirm('Apakah Anda yakin ingin menghapus berita ini? Tindakan ini tidak dapat dibatalkan.');
    if (!confirmed) return;

    console.log('Deleting news ID:', this.article.id);
    this.http.delete_news(this.article.id, this.currentUser.username).subscribe(
      (res: any) => {
        console.log('Delete response:', res);
        if (res.status === 'success') {
          this.showToast('Berita berhasil dihapus', 'success');
          // Navigate back after deletion
          setTimeout(() => {
            this.router.navigate(['/home']);
          }, 1000);
        }
      },
      (err: any) => {
        console.error('Gagal menghapus berita', err);
        if (err.status === 403) {
          this.showToast('Anda tidak memiliki izin menghapus berita ini', 'danger');
        } else {
          this.showToast('Gagal menghapus berita', 'danger');
        }
      }
    );
  }
}

import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { MOCK_CATEGORIES, MOCK_NEWS } from '../mock-data';
import { News, Category } from '../interface';
import { HttpService } from '../http-service';

@Component({
  selector: 'app-home',
  templateUrl: 'home.page.html',
  styleUrls: ['home.page.scss'],
  standalone: false,
})
export class HomePage {
  categories: Category[] = [];
  breakingNews: News | undefined;
  recommendations: News[] = [];

  constructor(private router: Router, private http: HttpService) {}
  ngOnInit() {
  }
  ionViewWillEnter() {
    this.loadNews();
    this.loadCategories();
  }
  loadCategories() {
    this.http.get_categories().subscribe(
      (res: any) => {
        if (res.status === 'success') {
          this.categories = res.data;
        }
      },
      (err) => {
        console.error('Gagal ambil kategori', err);
      }
    );
  }
  loadNews() {
    const allNews = MOCK_NEWS;
    if (allNews.length > 0) {
      this.breakingNews = allNews[0];
      this.recommendations = allNews.slice(1);
    }
  }
  goToNewsList(categoryId: number, categoryName: string) {
    this.router.navigate(['/news-list', categoryId, categoryName]);
  }
}

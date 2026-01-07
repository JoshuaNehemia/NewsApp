import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { MOCK_CATEGORIES, MOCK_NEWS } from '../mock-data';
import { News, Category } from '../interface';

@Component({
  selector: 'app-home',
  templateUrl: 'home.page.html',
  styleUrls: ['home.page.scss'],
  standalone: false,
})
export class HomePage {
  categories = MOCK_CATEGORIES;
  breakingNews: News | undefined;
  recommendations: News[] = [];

  constructor(private router: Router) {}
  ngOnInit() {
    this.loadData();
  }
  loadData() {
    // 1. Ambil semua berita (Nanti ini diganti this.httpService.getAllNews())
    const allNews = MOCK_NEWS;

    if (allNews.length > 0) {
      // 2. Berita terbaru (ID 1 di SQL kamu yg 'Alexander') jadi Breaking News
      // Note: Di SQL ID 1 tanggalnya paling lama, ID 7 paling baru.
      // Kalau mau Breaking News itu yg "Paling Baru", pakai ID 7.
      // Tapi kalau mau sesuai urutan insert, pakai index 0.

      // Opsi A: Ambil item pertama array (ID 1)
      this.breakingNews = allNews[0];

      // 3. Sisanya jadi rekomendasi (ID 2 s/d 7)
      this.recommendations = allNews.slice(1);
    }
  }
  goToNewsList(categoryId: number, categoryName: string) {
    this.router.navigate(['/news-list', categoryId, categoryName]);
  }
}

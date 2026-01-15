import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { NewsAPI, Category } from '../interface';
import { HttpService } from '../http-service';



@Component({
  selector: 'app-home',
  templateUrl: 'home.page.html',
  styleUrls: ['home.page.scss'],
  standalone: false,
})
export class HomePage {
  categories: Category[] = [];
  breakingNews: NewsAPI | undefined;
  recommendations: NewsAPI[] = [];
  searchQuery: string = '';
  searchResults: any[] = [];
  isSearching: boolean = false;

  constructor(private router: Router, private http: HttpService) { }
  ngOnInit() { }
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
    this.http.get_news().subscribe(
      (res: any) => {
        if (res.status === 'success') {
          const allNews: NewsAPI[] = res.data;

          if (allNews.length > 0) {
            this.breakingNews = allNews[0];
            this.recommendations = allNews.slice(1);
          }
        }
      },
      (error) => {
        console.error('Error fetching news:', error);
      }
    );
  }
  goToNewsList(categoryId: number, categoryName: string) {
    this.router.navigate(['/news-list', categoryId, categoryName]);
  }

  onSearchChange(event: any) {
    const query = event.detail.value;
    this.searchQuery = query;

    if (query && query.trim().length > 2) {
      this.performSearch(query.trim());
    } else {
      this.searchResults = [];
      this.isSearching = false;
    }
  }

  performSearch(query: string) {
    this.isSearching = true;
    this.http.search_news(query).subscribe(
      (res: any) => {
        if (res.status === 'success') {
          this.searchResults = res.data;
        } else {
          this.searchResults = [];
        }
      },
      (err) => {
        console.error('Search error:', err);
        this.searchResults = [];
      }
    );
  }

  goToNewsDetail(newsId: number) {
    this.router.navigate(['/news-detail', newsId]);
    // Clear search after navigation
    this.searchQuery = '';
    this.searchResults = [];
    this.isSearching = false;
  }

  clearSearch() {
    this.searchQuery = '';
    this.searchResults = [];
    this.isSearching = false;
  }
}

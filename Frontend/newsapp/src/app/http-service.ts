import { Injectable } from '@angular/core';
import { HttpClient, HttpParams, HttpHeaders } from '@angular/common/http';
import { Observable, Subject } from 'rxjs';
import { environment } from '../environments/environment';

const BASE_URL = environment.apiUrl;

@Injectable({
  providedIn: 'root',
})
export class HttpService {
  public userSubject = new Subject<any>();
  public favoritesChanged = new Subject<any>(); // New subject for favorites changes

  constructor(private http: HttpClient) { }

  get<T>(url: string, params?: any, headers?: HttpHeaders): Observable<T> {
    return this.http.get<T>(url, {
      params: new HttpParams({ fromObject: params }),
      headers,
    });
  }

  post<T>(url: string, body: any, headers?: HttpHeaders): Observable<T> {
    return this.http.post<T>(url, body, { headers });
  }

  put<T>(url: string, body: any, headers?: HttpHeaders): Observable<T> {
    console.log('Processing HTTP PUT Request');
    return this.http.put<T>(url, body, { headers });
  }

  delete<T>(url: string, params?: any, headers?: HttpHeaders): Observable<T> {
    console.log('Processing HTTP DELETE Request');
    return this.http.delete<T>(url, {
      params: new HttpParams({ fromObject: params }),
      headers,
    });
  }
  login_user(username_input: string, password_input: string): Observable<any> {
    const url = BASE_URL + 'login.php';
    const data = {
      username: username_input,
      password: password_input,
    };
    return this.post(url, data);
  }
  register_user(userData: any): Observable<any> {
    const url = BASE_URL + 'register.php';
    return this.post(url, userData);
  }
  register_writer(userData: any): Observable<any> {
    const url = BASE_URL + 'register_writer.php';
    return this.post(url, userData);
  }

  createNews(formData: FormData) {
    const url = BASE_URL + 'create_news.php';
    return this.post(url, formData);
  }
  emitUserLogin(userData: any) {
    this.userSubject.next(userData);
  }

  //#region GET DATA
  getMedias() {
    const url = BASE_URL + 'get_media.php';
    return this.get(url);
  }
  get_categories(): Observable<any> {
    const url = BASE_URL + 'get_categories.php';
    return this.get(url);
  }

  get_countries(): Observable<any> {
    const url = BASE_URL + 'get_countries.php';
    return this.get(url);
  }
  get_news(): Observable<any> {
    const url = BASE_URL + 'get_news.php';
    return this.get(url);
  }

  get_news_detail(id: number, username: string = ''): Observable<any> {
    const url = BASE_URL + 'get_news_by_id.php';
    return this.get(url, { id: id, username: username });
  }
  get_news_by_category(
    categoryId: number,
    page: number = 1,
    limit: number = 10
  ): Observable<any> {
    const url = BASE_URL + 'get_news_by_category.php';
    return this.get(url, { category_id: categoryId, page: page, limit: limit });
  }
  //#endregion
  //#region CREATE
  create_category(categoryData: any): Observable<any> {
    const url = BASE_URL + 'create_category.php';
    return this.post(url, categoryData);
  }
  create_news(newsData: FormData): Observable<any> {
    const url = BASE_URL + 'create_news.php';
    return this.post(url, newsData);
  }
  //#endregion
  //#region LIKE, VIEW, DELETE

  add_view(newsId: number): Observable<any> {
    const url = BASE_URL + 'view_count.php';
    return this.post(url, { news_id: newsId });
  }

  like_news(newsId: number, username: string): Observable<any> {
    const url = BASE_URL + 'like_news.php';
    return this.post(url, { news_id: newsId, username: username });
  }

  dislike_news(newsId: number, username: string): Observable<any> {
    const url = BASE_URL + 'dislike_news.php';
    return this.post(url, { news_id: newsId, username: username });
  }

  emitFavoritesChanged(data: any) {
    this.favoritesChanged.next(data);
  }

  get_user_favorites(username: string): Observable<any> {
    const url = BASE_URL + 'get_user_favorites.php';
    return this.get(url, { username: username });
  }

  add_comment(newsId: number, username: string, content: string, replyToId?: number): Observable<any> {
    const url = BASE_URL + 'add_comment.php';
    const body: any = { news_id: newsId, username: username, content: content };
    if (replyToId) {
      body.reply_to_id = replyToId;
    }
    return this.post(url, body);
  }

  get_comments(newsId: number): Observable<any> {
    const url = BASE_URL + 'get_comments.php';
    return this.get(url, { news_id: newsId });
  }

  add_rating(newsId: number, username: string, rate: number): Observable<any> {
    const url = BASE_URL + 'add_rating.php';
    return this.post(url, { news_id: newsId, username: username, rate: rate });
  }

  search_news(query: string, limit: number = 20): Observable<any> {
    const url = BASE_URL + 'search_news.php';
    return this.get(url, { query: query, limit: limit });
  }

  delete_news(newsId: number, username: string): Observable<any> {
    const url = BASE_URL + 'delete_news.php';
    // PHP receives JSON body for POST, but 'delete' method usually sends params in URL or body.
    // My PHP script reads file_get_contents("php://input") (body).
    // HttpClient.delete supports body in options, but 'post' is safer for compatibility if server expects POST.
    // The PHP header says Access-Control-Allow-Methods: POST (I set it in delete_news.php).
    // So I should use POST.
    return this.post(url, { news_id: newsId, username: username });
  }
  //#endregion
}

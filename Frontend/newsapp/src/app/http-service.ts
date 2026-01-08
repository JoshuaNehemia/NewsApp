import { Injectable } from '@angular/core';
import { HttpClient, HttpParams, HttpHeaders } from '@angular/common/http';
import { Observable, Subject } from 'rxjs';

const BASE_URL = 'http://localhost/NewsApp/Backend/api/';

@Injectable({
  providedIn: 'root',
})
export class HttpService {
  public userSubject = new Subject<any>();
  constructor(private http: HttpClient) {}

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
    const full_url = BASE_URL + 'login.php';
    const data = {
      username: username_input,
      password: password_input,
    };
    return this.post(full_url, data);
  }
  emitUserLogin(userData: any) {
    this.userSubject.next(userData);
  }

  register_user(userData: any): Observable<any> {
    const url = BASE_URL + 'register.php';
    return this.post(url, userData);
  }

  get_countries(): Observable<any> {
    const url = BASE_URL + 'get_countries.php';
    return this.get(url);
  }

  create_category(categoryData: any): Observable<any> {
    const url = BASE_URL + 'create_category.php';
    return this.post(url, categoryData);
  }

  get_categories(): Observable<any> {
    const url = BASE_URL + 'get_categories.php';
    return this.get(url);
  }

  get_news(): Observable<any> {
    const url = BASE_URL + 'get_news.php';
    return this.get(url);
  }

  get_news_detail(id: number): Observable<any> {
    const url = BASE_URL + 'get_news_by_id.php';
    return this.get(url, { id: id });
  }

  add_view(newsId: number): Observable<any> {
    const url = BASE_URL + 'view_count.php';
    return this.post(url, { news_id: newsId });
  }

  like_news(newsId: number): Observable<any> {
    const url = BASE_URL + 'like_news.php';
    return this.post(url, { news_id: newsId });
  }
}

import { Component } from '@angular/core';
import { Router } from '@angular/router';

@Component({
  selector: 'app-root',
  templateUrl: 'app.component.html',
  styleUrls: ['app.component.scss'],
  standalone: false,
})
export class AppComponent {
  user: any = {};

  constructor(private router: Router) {
    this.checkLoginStatus();
  }
  checkLoginStatus() {
    const data = localStorage.getItem('user_data');
    if (data) {
      this.user = JSON.parse(data);
    } else {
      this.router.navigate(['/login']);
    }
  }
  onLogout() {
    localStorage.clear();
    this.router.navigate(['/login']);
  }
}


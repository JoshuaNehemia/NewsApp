import { Component } from '@angular/core';
import { NEWS_ARTICLES, NEWS_CATEGORIES } from '../data';
import { Router } from '@angular/router';
import { AlertController } from '@ionic/angular';

@Component({
  selector: 'app-home',
  templateUrl: 'home.page.html',
  styleUrls: ['home.page.scss'],
  standalone: false,
})
export class HomePage {
  breakingNews: any = {};
  recommendations: any[] = [];
  categories: string[] = [];

  constructor(
    private router: Router,
    private alertController: AlertController
  ) {}


  async logout() {
    const alert = await this.alertController.create({
      header: 'Konfirmasi Logout',
      message: 'Yakin ingin logout?',
      buttons: [
        {
          text: 'Batal',
          role: 'Cancel',
        },
        {
          text: 'Logout',
          handler: () => {
            localStorage.clear();
            this.router.navigate(['/login']);
          },
        },
      ],
    });

    await alert.present();
  }


  ngOnInit() {
    // Ambil 1 berita sebagai breaking news
    this.breakingNews = NEWS_ARTICLES[0];
    
    // Ambil sisa berita sebagai rekomendasi
    this.recommendations = NEWS_ARTICLES.slice(1);
    
    this.categories = NEWS_CATEGORIES;
  }
}

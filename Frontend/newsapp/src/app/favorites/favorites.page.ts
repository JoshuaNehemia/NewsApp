import { Component, OnInit, OnDestroy } from '@angular/core';
import { HttpService } from '../http-service';
import { LoadingController } from '@ionic/angular';
import { Subscription } from 'rxjs';

@Component({
  selector: 'app-favorites',
  templateUrl: './favorites.page.html',
  styleUrls: ['./favorites.page.scss'],
  standalone: false,
})
export class FavoritesPage implements OnInit, OnDestroy {
  favorites: any[] = [];
  username: string = '';
  private favoritesSubscription?: Subscription;

  constructor(
    private httpService: HttpService,
    private loadingController: LoadingController
  ) { }

  ngOnInit() {
    this.loadFavorites();

    // Subscribe to favorites changes
    this.favoritesSubscription = this.httpService.favoritesChanged.subscribe(
      (data: any) => {
        if (data.isLiked) {
          // News was liked, load full data to add to favorites
          this.loadFavorites();
        } else {
          // News was unliked, remove from favorites
          this.favorites = this.favorites.filter(f => f.id !== data.newsId);
        }
      }
    );
  }

  ngOnDestroy() {
    if (this.favoritesSubscription) {
      this.favoritesSubscription.unsubscribe();
    }
  }

  async loadFavorites() {
    // Get username from localStorage
    const userData = localStorage.getItem('user_data');
    if (!userData) {
      return;
    }

    const user = JSON.parse(userData);
    this.username = user.username;

    const loading = await this.loadingController.create({
      message: 'Loading favorites...',
    });
    await loading.present();

    this.httpService.get_user_favorites(this.username).subscribe(
      (res: any) => {
        loading.dismiss();
        if (res.status === 'success') {
          this.favorites = res.data;
        }
      },
      (err) => {
        loading.dismiss();
        console.error('Error loading favorites:', err);
      }
    );
  }
}

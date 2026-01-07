export interface News {
  id: number;
  title: string;
  slug: string;
  content: string; // Deskripsi singkat atau isi
  main_image: string; // Hasil dari tabel news_images (sort_order = 0)
  author_name: string; // Hasil join ke tabel accounts (fullname)
  author_role: string; // 'Editor at CNN', dll
  published_at: string; // created_at
  category_name: string; // Hasil join ke tabel categories
  category_id: number;
  rating: number; // Rata-rata dari tabel rates
  is_favorite: boolean; // Status dari tabel likes (khusus user login)
  images: string[]; // Semua gambar terkait berita ini
  comments_count: number; // Jumlah komentar
}

export interface Category {
  id: number;
  name: string;
  icon?: string;
}

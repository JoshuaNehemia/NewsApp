import { News, Category } from './interface'

export const MOCK_CATEGORIES: Category[] = [
  { id: 1, name: 'Sports', icon: 'football-outline' },
  { id: 2, name: 'Technology', icon: 'hardware-chip-outline' },
  { id: 3, name: 'Economy', icon: 'cash-outline' },
  { id: 4, name: 'Health', icon: 'medkit-outline' },
];

export const MOCK_NEWS: News[] = [
  // ID 1: SQL News ID 1
  {
    id: 1,
    title: 'Alexander wears modified helmet in road races',
    slug: 'alexander-wears-modified-helmet',
    content:
      'As a tech department, we’re usually pretty good at spotting tech that’s out of the ordinary...',
    main_image: 'assets/images/cyclist-group.png',
    author_name: 'CNN Editor',
    author_role: 'Editor at CNN',
    published_at: '2025-02-27 10:00:00',
    category_id: 1,
    category_name: 'Sports',
    rating: 4.5,
    is_favorite: false,
    comments_count: 2,
    images: [
      'assets/images/cyclist-group.png',
      'assets/images/cyclist-helmet.png',
      'assets/images/cyclist-race.png',
      'assets/images/cyclist-motion.png',
    ],
  },
  // ID 2: SQL News ID 2
  {
    id: 2,
    title: 'What Training Do Volleyball Players Need?',
    slug: 'what-training-do-volleyball-players-need',
    content:
      'Volleyball requires a combination of strength, agility, and teamwork. This article explores...',
    main_image: 'assets/images/volleyball-training.png',
    author_name: 'McKindrey Author',
    author_role: 'Sports enthusiast',
    published_at: '2025-02-27 14:00:00',
    category_id: 1,
    category_name: 'Sports',
    rating: 4.8,
    is_favorite: true, // Sesuai simulasi SQL tabel likes
    comments_count: 0,
    images: [
      'assets/images/volleyball-training.png',
      'assets/images/volleyball-player.png',
      'assets/images/volleyball-team.png',
      'assets/images/volleyball-spike.png',
    ],
  },
  // ID 3: SQL News ID 3
  {
    id: 3,
    title: 'The Future of AI in Modern Technology',
    slug: 'future-of-ai-modern-tech',
    content:
      'Artificial Intelligence is reshaping our world. From autonomous vehicles to personalized medicine...',
    main_image: 'assets/images/ai-technology.png',
    author_name: 'Tech Editor',
    author_role: 'Tech geek',
    published_at: '2025-03-01 09:00:00',
    category_id: 2,
    category_name: 'Technology',
    rating: 4.9,
    is_favorite: false,
    comments_count: 5,
    images: [
      'assets/images/ai-technology.png',
      'assets/images/ai-robot.png',
      'assets/images/ai-data.png',
      'assets/images/ai-future.png',
    ],
  },
  // ID 4: SQL News ID 4
  {
    id: 4,
    title: 'Global Markets React to New Economic Policies',
    slug: 'global-markets-react-economic-policies',
    content:
      'New fiscal policies have sent ripples through the global markets. Experts analyze...',
    main_image: 'assets/images/stock-market.png',
    author_name: 'Finance Analyst',
    author_role: 'Economist',
    published_at: '2025-03-02 11:30:00',
    category_id: 3,
    category_name: 'Economy',
    rating: 0, // Belum ada rating di SQL dummy
    is_favorite: false,
    comments_count: 0,
    images: [
      'assets/images/stock-market.png',
      'assets/images/economic-policy.png',
      'assets/images/global-finance.png',
      'assets/images/trade-investment.png',
    ],
  },
  // ID 5: SQL News ID 5
  {
    id: 5,
    title: 'Quantum Computing Breakthrough Announced',
    slug: 'quantum-computing-breakthrough',
    content:
      'A major breakthrough in quantum computing has been announced by leading researchers...',
    main_image: 'assets/images/quantum-computer.png',
    author_name: 'TC Reporter',
    author_role: 'Tech reporter',
    published_at: '2025-03-05 15:45:00',
    category_id: 2,
    category_name: 'Technology',
    rating: 0,
    is_favorite: false,
    comments_count: 0,
    images: [
      'assets/images/quantum-computer.png',
      'assets/images/quantum-lab.png',
      'assets/images/quantum-chip.png',
      'assets/images/quantum-data.png',
    ],
  },
  // ID 6: SQL News ID 6
  {
    id: 6,
    title: 'Startup Funding Trends in Southeast Asia',
    slug: 'startup-funding-trends-sea',
    content:
      'Startup ecosystems across Southeast Asia are experiencing a surge in funding...',
    main_image: 'assets/images/startup-funding.png',
    author_name: 'Startup Journalist',
    author_role: 'Startup observer',
    published_at: '2025-03-06 08:20:00',
    category_id: 3,
    category_name: 'Economy',
    rating: 0,
    is_favorite: false,
    comments_count: 0,
    images: [
      'assets/images/startup-funding.png',
      'assets/images/startup-team.png',
      'assets/images/startup-pitch.png',
      'assets/images/startup-growth.png',
    ],
  },
  // ID 7: SQL News ID 7
  {
    id: 7,
    title: 'Mental Health Awareness in Sports',
    slug: 'mental-health-awareness-sports',
    content:
      'Mental health has become a growing concern in the world of sports...',
    main_image: 'assets/images/mental-health-sports.png',
    author_name: 'Dr. Health',
    author_role: 'Medical professional',
    published_at: '2025-03-07 13:10:00',
    category_id: 4,
    category_name: 'Health',
    rating: 4.4,
    is_favorite: false,
    comments_count: 0,
    images: [
      'assets/images/mental-health-sports.png',
      'assets/images/mental-health-athlete.png',
      'assets/images/mental-health-support.png',
      'assets/images/mental-health-talk.png',
    ],
  },
];

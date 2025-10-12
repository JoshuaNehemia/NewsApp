// data.ts
import { NewsArticle, User } from './interfaces';

export const USERS: User[] = [
  { username: 'budi123', name: 'Budi Santoso', password: 'budiPass123' },
  { username: 'ani456', name: 'Ani Rahmawati', password: 'aniPass456' },
  { username: 'vivian', name: 'Vivian', password: 'vivian' },
];

export const NEWS_CATEGORIES: string[] = ['Sports', 'Technology', 'Economy', 'Health'];

export const NEWS_ARTICLES: NewsArticle[] = [
  {
    id: 1,
    title: 'Alexander wears modified helmet in road races',
    author: 'CNN Indonesia',
    date: 'Feb 27, 2025',
    categories: ['Sports'],
    rating: 4.5,
    ratingsCount: 150,
    isFavorite: false,
    content:
      'As a tech department, we’re usually pretty good at spotting tech that’s out of the ordinary. During time trials we’re used to seeing new aero innovation, and while there are certainly aero tricks used in road stages, they are harder to spot.',
    mainImage: 'assets/images/cyclist-group.png',
    images: [
      'assets/images/cyclist-group.png',
      'assets/images/cyclist-helmet.png',
      'assets/images/cyclist-race.png',
      'assets/images/cyclist-motion.png'

    ],
    comments: [
      { user: USERS[0], text: 'Berita yang sangat menarik!' },
      { user: USERS[1], text: 'Penjelasannya mudah dipahami.' }
    ]
  },
  {
    id: 2,
    title: 'What Training Do Volleyball Players Need?',
    author: 'McKindrey',
    date: 'Feb 27, 2025',
    categories: ['Sports', 'Health'],
    rating: 4.8,
    ratingsCount: 210,
    isFavorite: true,
    content:
      'Volleyball requires a combination of strength, agility, and teamwork. This article explores the essential training regimens for aspiring volleyball players to excel on the court.',
    mainImage: 'assets/images/volleyball-training.png',
    images: [
      'assets/images/volleyball-training.png',
      'assets/images/volleyball-player.png',
      'assets/images/volleyball-team.png',
      'assets/images/volleyball-spike.png'
    ],
    comments: []
  },
  {
    id: 3,
    title: 'The Future of AI in Modern Technology',
    author: 'Tech Weekly',
    date: 'Mar 1, 2025',
    categories: ['Technology'],
    rating: 4.9,
    ratingsCount: 500,
    isFavorite: false,
    content:
      'Artificial Intelligence is reshaping our world. From autonomous vehicles to personalized medicine, discover the breakthroughs that are defining the next generation of technology.',
    mainImage: 'assets/images/ai-technology.png',
    images: [
      'assets/images/ai-technology.png',
      'assets/images/ai-robot.png',
      'assets/images/ai-data.png',
      'assets/images/ai-future.png'
    ],
    comments: []
  },
  {
    id: 4,
    title: 'Global Markets React to New Economic Policies',
    author: 'Finance Today',
    date: 'Mar 2, 2025',
    categories: ['Economy'],
    rating: 4.2,
    ratingsCount: 120,
    isFavorite: false,
    content:
      'New fiscal policies have sent ripples through the global markets. Experts analyze the potential long-term effects on trade and investment across major economies.',
    mainImage: 'assets/images/stock-market.png',
    images: [
        'assets/images/stock-market.png',
        'assets/images/economic-policy.png',
        'assets/images/global-finance.png',
        'assets/images/trade-investment.png'
    ],
    comments: []
  },
  {
    id: 5,
    title: 'Quantum Computing Breakthrough Announced',
    author: 'TechCrunch',
    date: 'Mar 5, 2025',
    categories: ['Technology', 'Economy'],
    rating: 4.7,
    ratingsCount: 320,
    isFavorite: false,
    content: 'A major breakthrough in quantum computing has been announced by leading researchers, promising to accelerate the development of ultra-fast and highly secure computing systems. This advancement involves the creation of more stable qubits and improved error correction techniques, which are essential for scaling quantum processors. Experts believe this could revolutionize industries such as cryptography, pharmaceuticals, and financial modeling, making previously impossible computations achievable in seconds.',
    mainImage: 'assets/images/quantum-computer.png',
    images: [
        'assets/images/quantum-computer.png',
        'assets/images/quantum-lab.png',
        'assets/images/quantum-chip.png',
        'assets/images/quantum-data.png'
    ],
    comments: []
  },
  {
    id: 6,
    title: 'Startup Funding Trends in Southeast Asia',
    author: 'Startup Daily',
    date: 'Mar 6, 2025',
    categories: ['Economy', 'Technology'],
    rating: 4.6,
    ratingsCount: 180,
    isFavorite: false,
    content: 'Startup ecosystems across Southeast Asia are experiencing a surge in funding, driven by increased interest from global venture capital firms and government-backed innovation programs. Countries like Indonesia, Vietnam, and Singapore are leading the charge, with fintech, healthtech, and e-commerce startups attracting the most investment. Analysts predict that this trend will continue as digital adoption grows and regional markets mature, creating new opportunities for entrepreneurs and investors alike.',
    mainImage: 'assets/images/startup-funding.png',
    images: [
        'assets/images/startup-funding.png',  
        'assets/images/startup-team.png',
        'assets/images/startup-pitch.png',
        'assets/images/startup-growth.png'
    ],
    comments: []
  },
  {
    id: 7,
    title: 'Mental Health Awareness in Sports',
    author: 'HealthLine',
    date: 'Mar 7, 2025',
    categories: ['Health', 'Sports'],
    rating: 4.4,
    ratingsCount: 95,
    isFavorite: false,
    content: 'Mental health has become a growing concern in the world of sports, with athletes increasingly speaking out about the pressures they face both on and off the field. From performance anxiety to burnout, the psychological challenges of competitive sports are gaining recognition. Organizations and teams are now implementing mental wellness programs, offering counseling and support to help athletes maintain balance and resilience. This shift marks a significant step toward destigmatizing mental health in athletic communities.',
    mainImage: 'assets/images/mental-health-sports.png',
    images: [
      'assets/images/mental-health-sports.png',
      'assets/images/mental-health-athlete.png',
      'assets/images/mental-health-support.png',
      'assets/images/mental-health-talk.png'
    ],
    comments: []
  }
];

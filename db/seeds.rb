require './test/test_helper.rb'
include CategoryItemsSetup

User.create(username: "admin",
            password: "password",
            role: 1,
            email: "admin@bmc.com")

User.create(username: "user",
            password: "password",
            role: 0,
            email: "user@bmc.com")

# Category.create([{ title: 'Apparel' }, { title: 'Snowboards' }, { title: 'Boots' }, { title: 'Bindings' }])
#
# apparel = Category.find_by(title: 'Apparel')
#           .items
#           .create([{ name: 'Hoody',
#                      description: 'Keeps you slightly warm',
#                      price: 80,
#                      brand: 'Nomis',
#                      image: File.open('app/assets/images/hoody.jpg')
#                  },
#
#                    { name: 'Sweet Jacket',
#                      description: 'Keeps you warm',
#                      price: 240,
#                      brand: 'NEFF',
#                      image: File.open('app/assets/images/jacket.jpg')
#                    },
#                    { name: 'SODO JACKET',
#                      description: "The Admiral snowboard jacket protects with authority! The 37.5 technology by Cocona offers 20K rated highly waterproof
#                                   protection on the outside and manages moisture while it's forming on the inside for next level breathability. This genius
#                                   highly waterproof jacket comes complete with our ACT2 zonal insulation system, fully taped seams,YKK AquaGuard exposed zipper",
#                      price: 190,
#                      brand: 'Ride',
#                      image: File.open('app/assets/images/sodo_jacket.png')
#                    },
#                    { name: '3.5L HOLMAN BIB',
#                      description: 'We all love to do the snow dance, but no one loves to do the snow in my pants dance. We’ve taken the most functional
#                                   outerwear garment you can have in extreme conditions, added 37.5 Technology to keep your body at an optimal moisture
#                                   balance, reinforced the knees and butt for extra protection from the elements, and added a 4 way stretch lycra bib
#                                   that gives you the freedom and comfort to be wedgie free no matter how much you tweak your grabs. This is the optimal
#                                   pant to be snow-free for riders of all abilities.',
#                      price: 125,
#                      brand: 'Ride',
#                      image: File.open('app/assets/images/holman_bib.png')
#                    },
#                    { name: 'ZIP HOODIE',
#                      description: 'Features: 80% cotton, 20% polyester Colors: Heather Gray, Olive Sizes: S, M, L, XL',
#                      price: 60,
#                      brand: 'K2',
#                      image: File.open('app/assets/images/good_vibes_hoody.png')
#                    },
#                    { name: '[AK] Tech Glove',
#                      description: 'Low-profile warmth meets the bomber strength of genuine leather. A team-favorite for sledding, splitboarding, and hiking.',
#                      price: 40,
#                      brand: 'Burton',
#                      image: File.open('app/assets/images/ak_gloves.jpg')
#                    },
#                    { name: 'B-10 Jacket',
#                      description: 'Outlast 70% Cotton, 30% Nylon',
#                      price: 240,
#                      brand: 'NEFF',
#                      image: File.open('app/assets/images/bomber_jacket.jpeg')
#                    }])
#
# snowboards = Category.find_by(title: 'Snowboards')
#              .items
#              .create([{ name: 'gwar possum',
#                         description: 'a snowboard for gwar concerts',
#                         price: 15,
#                         brand: 'Jibberish',
#                         image: File.open('app/assets/images/gwar_possum.jpg')
#                  },
#
#                       { name: 'gnar possum',
#                         description: 'a snowboard for shredding gnar pow',
#                         price: 1000,
#                         brand: 'Never Summer',
#                         image: File.open('app/assets/images/gnar_possum.jpg')
#                       },
#                       { name: 'gnar possum',
#                         description: 'a snowboard for shredding gnar pow',
#                         price: 1000,
#                         brand: 'Never Summer',
#                         image: File.open('app/assets/images/gnar_possum.jpg')
#                       },
#                       { name: 'WILD LIFE WIDE',
#                         description: 'Joining forces with Ride engineers, team rider Marco Feichtner had a hand in refining this dialed ride. Delivering
#                                       versatility for everything the mountain has to offer, the Wild Life wide snowboard features Ride’s All Mountain Rocker
#                                       shape with playful LowRize rocker in the nose and the grippy stability of the flat zone under foot and through the tail.
#                                       Complete with Slimewalls® sidewall, Carbon Array 3 laminates and Fusion 4000 base, this directional Ride will have you
#                                       running wild from peak to park, with a responsive feel that won’t let you down.',
#                         price: 600,
#                         brand: 'Ride',
#                         image: File.open('app/assets/images/wild_life.png')
#                       },
#                       { name: 'KINK SNOWBOARD',
#                         description: 'The Kink got a facelift with a new shape, improved tech and art by the legendary, Sean Cliver. Twin Rocker and new
#                                       Roll In Slimewalls make up the most durable board from the park to the streets.',
#                         price: 430,
#                         brand: 'Ride',
#                         image: File.open('app/assets/images/kink.png')
#                       },
#                       { name: 'WWW SNOWBOARD',
#                         description: 'The WWW continues its long history of creative jib progression. Carrying on it’s 2014 redesign into a second year
#                                       it is a team go-to for looking at freestyle snowboarding in new and creative ways.',
#                         price: 444,
#                         brand: 'K2',
#                         image: File.open('app/assets/images/www_144.png')
#                       },
#                       { name: 'FASTPLANT',
#                         description: 'No other board pops harder and slashes heavier for longer than the K2 Fastplant. The primary freestyle ride for K2
#                                       team riders Jake Kuzyk and Matt Belzile, this Bambooyah powered all-mountain fresstyle deck balances power and technical
#                                       finesse.',
#                         price: 480,
#                         brand: 'K2',
#                         image: File.open('app/assets/images/fastplant.png')
#                       },
#                       { name: 'Burton Process',
#                         description: 'Take your freestyle further with the snowboard Mark McMorris chooses for lightweight performance and action-packed pop.',
#                         price: 600,
#                         brand: 'Burton',
#                         image: File.open('app/assets/images/burton_process.jpg')
#                       },
#                       { name: 'Throwback',
#                         description: 'A resurrection of the 1981 Burton Backhill, this ride-able piece of history is built for surfing snow in your own backyard.
#                                       While this snowboard is gripped and ready to rip, it is not recommended for riding at resorts or on hardpack or icy conditions.
#                                       Please consult your resort before riding The Throwback on their trails.',
#                         price: 325,
#                         brand: 'Burton',
#                         image: File.open('app/assets/images/neighborhood_throwback.jpeg')
#                       }])
#
# boots = Category.find_by(title: 'Boots')
#         .items
#         .create([{ name: 'cool boots',
#                    description: 'These boots were made for shreddin',
#                    price: 200,
#                    brand: 'Ride',
#                    image: File.open('app/assets/images/boots1.jpg')
#                },
#
#                  { name: 'gnar kicks',
#                    description: 'Foot-tappin-good boots. These puppies will keep you warm.',
#                    price: 150,
#                    brand: 'Thirty-Two',
#                    image: File.open('app/assets/images/boot2.jpg')
#                  },
#                  { name: 'TRIAD BOOTS',
#                    description: 'The Triad strikes a chord with freestyle riders as the go to performance snowboard boot built to last. Featuring the Tongue Tied Boa
#                                  closure system for next level heel hold and maximum control on a traditional lace snowboard boot. Blending top technologies such as
#                                  the all new FlexLight outsole for better cushioning and custom fitting Intuition Mobile Foam Liner, these lightweight kicks prove
#                                  durable and supportive, park lap after park lap.',
#                    price: 230,
#                    brand: 'Ride',
#                    image: File.open('app/assets/images/triad_boots.png')
#                  },
#                  { name: 'HASHTAG BOOT',
#                    description: 'K2’s Fast-In technology keeps things simple and quick so more time is spent actually snowboarding rather than fighting with a boot
#                                  that would rather stay home.',
#                    price: 170,
#                    brand: 'K2',
#                    image: File.open('app/assets/images/hashtag.png')
#                  }])
#
# bindings = Category.find_by(title: 'Bindings')
#            .items
#            .create([{ name: 'Foot Binders',
#                       description: 'These things are most-necessary, they keep your feet on the board',
#                       price: 300,
#                       brand: 'Ride',
#                       image: File.open('app/assets/images/bidndings1.jpg')
#                     },
#
#                     { name: 'Anti-kickflippers',
#                       description: 'No kickflips allow with the Salomon Anti-kickflippers',
#                       price: 150,
#                       brand: 'Salomon',
#                       image: File.open('app/assets/images/bindings2.jpg')
#                     },
#                     { name: 'EX BINDINGS',
#                       description: "Built for versatility and durability, the EX snowboard binding features RIDE's all new aluminum Edge chassis to provide
#                                     all-mountain performance and flex, and Wedgie footbeds for a boost of pop and support. Topped off with the ThinGrip Plus
#                                     toe strap, RAM ankle strap and the AstroGlyde OG ratchets, you won’t find a better value for any level of rider.",
#                       price: 200,
#                       brand: 'Ride',
#                       image: File.open('app/assets/images/ex_orange.png')
#                     },
#                     { name: 'LIEN AT BINDING',
#                       description: 'Choice binding of K2 team riders such as Matt Belzile, the Lien AT represents a breakthrough in the balance of critical
#                                     support and natural flex and movement. Built for the no-nonsense rider that wants bindings that move and support with you,
#                                     not against you.',
#                       price: 75,
#                       brand: 'K2',
#                       image: File.open('app/assets/images/lien_at.png')
#                     },
#                     { name: 'Mission EST',
#                       description: 'Blast in the binding built to outlast all takers with highly versatile mid-range response and unstoppable strength.',
#                       price: 200,
#                       brand: 'Burton',
#                       image: File.open('app/assets/images/mission_binding.jpeg')
#                     }])

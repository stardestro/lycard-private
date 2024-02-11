import Image from "next/image";
import * as React from "react";


export default function CardsList() {
   const cards = {
    "records": [
      {
        "image": {
          "value": "https://icm.aexp-static.com/acquisition/card-art/NUS000000174_480x304_straight_withname.png"
        },
        "restaurant": {
          "value": "4"
        },
        "name": {
          "value": "American Express Gold Card"
        },
        "gas": {
          "value": "1"
        },
        "shopping_0": {
          "value": "4"
        },
        "id": {
          "value": "american-express-gold-card"
        },
        "travel": {
          "value": "3"
        }
      },
      {
        "image": {
          "value": "https://icm.aexp-static.com/acquisition/card-art/NUS000000237_480x304_straight_withname.png"
        },
        "restaurant": {
          "value": "1"
        },
        "name": {
          "value": "The Platinum Card from American Express"
        },
        "gas": {
          "value": "1"
        },
        "shopping_0": {
          "value": "1"
        },
        "id": {
          "value": "the-platinum-card-from-american-express"
        },
        "travel": {
          "value": "5"
        }
      },
      {
        "image": {
          "value": "https://ecm.capitalone.com/WCM/card/products/quicksilver-card-art.png"
        },
        "restaurant": {
          "value": "1.5"
        },
        "name": {
          "value": "Capital One Quicksilver Cash Rewards Credit Card"
        },
        "gas": {
          "value": "1.5"
        },
        "shopping_0": {
          "value": "1.5"
        },
        "id": {
          "value": "capital-one-quicksilver-cash-rewards-credit-card"
        },
        "travel": {
          "value": "1.5"
        }
      },
      {
        "image": {
          "value": "https://ecm.capitalone.com/WCM/card/products/savorone-card-art.png"
        },
        "restaurant": {
          "value": "3"
        },
        "name": {
          "value": "Capital One SavorOne Cash Rewards Credit Card"
        },
        "gas": {
          "value": "1"
        },
        "shopping_0": {
          "value": "3"
        },
        "id": {
          "value": "capital-one-savorone-cash-rewards-credit-card"
        },
        "travel": {
          "value": "1"
        }
      },
      {
        "image": {
          "value": "https://ecm.capitalone.com/WCM/card/products/venture-card-art.png"
        },
        "restaurant": {
          "value": "1"
        },
        "name": {
          "value": "Capital One Venture Rewards Credit Card"
        },
        "gas": {
          "value": "1"
        },
        "shopping_0": {
          "value": "1"
        },
        "id": {
          "value": "capital-one-venture-rewards-credit-card"
        },
        "travel": {
          "value": "2.5"
        }
      },
      {
        "image": {
          "value": "https://ecm.capitalone.com/WCM/card/products/venturex-cg-static-card-1000x630-2.png"
        },
        "restaurant": {
          "value": "1"
        },
        "name": {
          "value": "Capital One Venture X Rewards Credit Card"
        },
        "gas": {
          "value": "1"
        },
        "shopping_0": {
          "value": "1"
        },
        "id": {
          "value": "capital-one-venture-x-rewards-credit-card"
        },
        "travel": {
          "value": "2.5"
        }
      },
      {
        "image": {
          "value": "https://www.bankofamerica.com/content/images/ContextualSiteGraphics/CreditCardArt/en_US/Approved_PCM/8ckn_cshsigcm_v_250x158.png"
        },
        "restaurant": {
          "value": "1"
        },
        "name": {
          "value": "Bank of America Cash Rewards Credit Card for Students"
        },
        "gas": {
          "value": "1"
        },
        "shopping_0": {
          "value": "2"
        },
        "id": {
          "value": "bank-of-america-cash-rewards-credit-card-for-students"
        },
        "travel": {
          "value": "1"
        }
      },
      {
        "image": {
          "value": "https://media.chase.com/content/dam/chase/media-center/pr/card_prime_vs.jpg"
        },
        "restaurant": {
          "value": "1"
        },
        "name": {
          "value": "Amazon Rewards Visa Signature Card"
        },
        "gas": {
          "value": "2"
        },
        "shopping_0": {
          "value": "3"
        },
        "id": {
          "value": "amazon-rewards-visa-signature-card"
        },
        "travel": {
          "value": "1"
        }
      },
      {
        "image": {
          "value": "https://creditcards.chase.com/K-Marketplace/images/cardart/freedom_unlimited_card.png"
        },
        "restaurant": {
          "value": "3"
        },
        "name": {
          "value": "Chase Freedom Unlimited"
        },
        "gas": {
          "value": "1.5"
        },
        "shopping_0": {
          "value": "1.5"
        },
        "id": {
          "value": "chase-freedom-unlimited"
        },
        "travel": {
          "value": "5"
        }
      },
      {
        "image": {
          "value": "https://creditcards.chase.com/K-Marketplace/images/cardart/freedom_flex_card.png"
        },
        "restaurant": {
          "value": "5"
        },
        "name": {
          "value": "Chase Freedom Flex"
        },
        "gas": {
          "value": "5"
        },
        "shopping_0": {
          "value": "1"
        },
        "id": {
          "value": "chase-freedom-flex"
        },
        "travel": {
          "value": "1"
        }
      },
      {
        "image": {
          "value": "https://creditcards.chase.com/K-Marketplace/images/cardart/sapphire_preferred_card.png"
        },
        "restaurant": {
          "value": "4.5"
        },
        "name": {
          "value": "Chase Sapphire Preferred Card"
        },
        "gas": {
          "value": "1.5"
        },
        "shopping_0": {
          "value": "4.5"
        },
        "id": {
          "value": "chase-sapphire-preferred-card"
        },
        "travel": {
          "value": "7.5"
        }
      },
      {
        "image": {
          "value": "https://creditcards.chase.com/K-Marketplace/images/cardart/sapphire_reserve_card.png"
        },
        "restaurant": {
          "value": "4.5"
        },
        "name": {
          "value": "Chase Sapphire Reserve"
        },
        "gas": {
          "value": "1.5"
        },
        "shopping_0": {
          "value": "1.5"
        },
        "id": {
          "value": "chase-sapphire-reserve"
        },
        "travel": {
          "value": "4.5"
        }
      },
      {
        "image": {
          "value": " https://creditcards.chase.com/K-Marketplace/images/cardart/swa_plus_card.png"
        },
        "restaurant": {
          "value": "1.4"
        },
        "name": {
          "value": "Southwest Rapid Rewards Plus Credit Card"
        },
        "gas": {
          "value": "1.4"
        },
        "shopping_0": {
          "value": "1.4"
        },
        "id": {
          "value": "southwest-rapid-rewards-plus-credit-card"
        },
        "travel": {
          "value": "1.4"
        }
      },
      {
        "image": {
          "value": "https://creditcards.aa.com/wp-content/uploads/2018/07/milesup_card-hires.png.webp"
        },
        "restaurant": {
          "value": "1.7"
        },
        "name": {
          "value": "American Airlines AAdvantage MileUp"
        },
        "gas": {
          "value": "1.7"
        },
        "shopping_0": {
          "value": "3.4"
        },
        "id": {
          "value": "american-airlines-aadvantage-mileup"
        },
        "travel": {
          "value": "1.7"
        }
      },
      {
        "image": {
          "value": "https://pisces.bbystatic.com/image2/BestBuy_US/Gallery/gl-26790-cc-page-2018-single-visa-47310.png"
        },
        "restaurant": {
          "value": "2"
        },
        "name": {
          "value": "My Best Buy Visa Card"
        },
        "gas": {
          "value": "3"
        },
        "shopping_0": {
          "value": "2"
        },
        "id": {
          "value": "my-best-buy-visa-card"
        },
        "travel": {
          "value": "1"
        }
      },
      {
        "image": {
          "value": "https://www.citi.com/CRD/images/citi-double-cash/citi-double-cash_341x215.png"
        },
        "restaurant": {
          "value": "1"
        },
        "name": {
          "value": "Citi Double Cash Card"
        },
        "gas": {
          "value": "1"
        },
        "shopping_0": {
          "value": "1"
        },
        "id": {
          "value": "citi-double-cash-card"
        },
        "travel": {
          "value": "1"
        }
      },
      {
        "image": {
          "value": "https://www.nerdwallet.com/cdn-cgi/image/width=1000,quality=85/cdn/images/marketplace/credit_cards/44278d8b-631e-49c9-90df-f11b6e101539/1e30d48429dfe33c0d61d0c069acfec0e1328a89851742e18d6e6056cb272769.jpg"
        },
        "restaurant": {
          "value": "5"
        },
        "name": {
          "value": "Discover it Cash Back"
        },
        "gas": {
          "value": "1"
        },
        "shopping_0": {
          "value": "1"
        },
        "id": {
          "value": "discover-it-cash-back"
        },
        "travel": {
          "value": "1"
        }
      },
      {
        "image": {
          "value": "https://cdn.prodstatic.com/shared/images/cards/500x315/5d472db0-f540-11eb-99d8-ddd3faec9ad4.png"
        },
        "restaurant": {
          "value": "2"
        },
        "name": {
          "value": "Apple Card"
        },
        "gas": {
          "value": "2"
        },
        "shopping_0": {
          "value": "2"
        },
        "id": {
          "value": "apple-card"
        },
        "travel": {
          "value": "2"
        }
      },
      {
        "image": {
          "value": "https://content.usaa.com/mcontent/static_assets/Media/cashback-rewards-plus-american-express-card-flat-new-look-v1.png?cacheid=3730707232_p"
        },
        "restaurant": {
          "value": "1"
        },
        "name": {
          "value": "USAA Cashback Rewards Plus American Express Card"
        },
        "gas": {
          "value": "5"
        },
        "shopping_0": {
          "value": "2"
        },
        "id": {
          "value": "usaa-cashback-rewards-plus-american-express-card"
        },
        "travel": {
          "value": "1"
        }
      },
      {
        "image": {
          "value": "https://merchant.linksynergy.com/fs/banners/40602/40602_36.png"
        },
        "restaurant": {
          "value": "2"
        },
        "name": {
          "value": "Wells Fargo Active Cash Card"
        },
        "gas": {
          "value": "2"
        },
        "shopping_0": {
          "value": "2"
        },
        "id": {
          "value": "wells-fargo-active-cash-card"
        },
        "travel": {
          "value": "2"
        }
      }
    ]
  }

  return (
    <div className="mr-4 flex flex-row flex-wrap items-center justify-start">
      {cards.records.map((card) => (
        <div className="flex flex-col items-center justify-center p-4" key={card.name.value}>
          <Image src={card.image.value} alt={card.name.value} className="w-48 h-32" width="192" height="192" />
          <p className="text-lg font-bold">{card.name.value}</p>
          <p>Restaurant: {card.restaurant.value}</p>
          <p>Gas: {card.gas.value}</p>
          <p>Shopping: {card.shopping_0.value}</p>
          <p>Travel: {card.travel.value}</p>
        </div>
      ))}
    </div>
  );
}

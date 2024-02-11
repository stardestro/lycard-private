/** @type {import('next').NextConfig} */
const nextConfig = {
  output: "standalone",
  images: {
    remotePatterns: [
      {
        protocol: "https",
        hostname: "avatars.githubusercontent.com",
      },
      {
        protocol: "https",
        hostname: "lh3.googleusercontent.com",
      },
      {
        protocol: "https",
        hostname: "icm.aexp-static.com",
      },
      {
        protocol: "https",
        hostname: "ecm.capitalone.com",
      },
      {
        protocol: "https",
        hostname: "www.discover.com",
      },
      {
        protocol: "https",
        hostname: "www.bankofamerica.com",
      },
      {
        protocol: "https",
        hostname: "media.chase.com",
      },
      {
        protocol: "https",
        hostname: "www.citi.com",
      },
      {
        protocol: "https",
        hostname: "www.wellsfargo.com",
      },
      {
        protocol: "https",
        hostname: "www.capitalone.com",
      },
      {
        protocol: "https",
        hostname: "www.americanexpress.com",
      },
      {
        protocol: "https",
        hostname: "creditcards.chase.com",
      },
      {
        protocol: "https",
        hostname: "creditcards.aa.com",
      },
      {
        protocol: "https",
        hostname: "pisces.bbystatic.com",
      },
      {
        protocol: "https",
        hostname: "www.nerdwallet.com",
      },
      {
        protocol: "https",
        hostname: "cdn.prodstatic.com",
      },
      {
        protocol: "https",
        hostname: "content.usaa.com",
      },
      {
        protocol: "https",
        hostname: "merchant.linksynergy.com",
      },
    ],
  },
  async redirects() {
    return [
      {
        source: "/github",
        destination: "https://github.com/lryanle/lycard",
        permanent: false,
      },
    ];
  },
};

module.exports = nextConfig

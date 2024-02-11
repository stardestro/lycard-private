import { MainNavItem, SidebarNavItem } from "@/types/nav"

interface DocsConfig {
  mainNav: MainNavItem[]
}

export const docsConfig: DocsConfig = {
  mainNav: [
    {
      title: "Home",
      href: "/",
    },
    {
      title: "Cards",
      href: "/cards",
    },
    {
      title: "Search",
      href: "/search",
    },
    {
      title: "GitHub",
      href: "https://github.com/lryanle/lycard",
      external: true,
    },
  ],
}

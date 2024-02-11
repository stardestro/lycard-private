import Link from "next/link"

import { siteConfig } from "@/config/site"
import { cn } from "@/lib/utils"
import { Icons } from "@/components/icons"
import Navbar from "@/components/layout/navbar"
import { MobileNavbar } from "@/components/layout/mobile-navbar"
import { buttonVariants } from "@/components/ui/button"
import { ModeToggle } from "./mode-toggle";

export function SiteHeader() {
  return (
    <header className="sticky top-0 z-50 w-full border-b border-border/40 bg-background/95 backdrop-blur supports-[backdrop-filter]:bg-background/60">
      <div className="container flex h-14 max-w-screen-2xl justify-between md:justify-center items-center ">
        <Navbar />
        <div className="md:flex flex-1 items-center justify-between space-x-2 hidden md:justify-end">
          <nav className="items-center hidden md:flex">
            <Link
              href={siteConfig.links.lryanleGithub}
              target="_blank"
              rel="noreferrer"
            >
              <div
                className={cn(
                  buttonVariants({
                    variant: "ghost",
                  }),
                  "w-9 h-9 rounded-full px-0"
                )}
              >
                <Icons.gitHub className="h-6 w-6" />
                <span className="sr-only">GitHub</span>
              </div>
            </Link>
          </nav>
          <Link href="/" className="mr-6 flex items-center space-x-2 md:hidden">
            <div className="w-6 h-6">
              <Icons.logo className="h-6 w-6" />
            </div>
            <span className="font-bold sm:inline-block">
              {siteConfig.name}
            </span>
          </Link>
          <ModeToggle className="hidden md:flex" />
        </div>

        <MobileNavbar />
      </div>
    </header>
  )
}

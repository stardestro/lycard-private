import { siteConfig } from "@/config/site";
import Link from "next/link";

export function SiteFooter() {
	return (
		<footer className="py-6 md:px-8 md:py-0 border-t">
			<div className="container flex flex-col items-center justify-between gap-4 md:h-16 md:flex-row">
				<p className="text-balance text-center text-sm leading-loose text-muted-foreground md:text-left">
					Built by{" "}
					<Link
						href={siteConfig.links.hussainPersonalsite}
						target="_blank"
						rel="noreferrer"
						className="font-medium underline underline-offset-4"
					>
						stardestro
					</Link>
          {" "}and{" "}
          <Link
						href={siteConfig.links.lryanlePersonalsite}
						target="_blank"
						rel="noreferrer"
						className="font-medium underline underline-offset-4"
					>
            lryanle
          </Link>
					. The source code is available on{" "}
					<Link
						href={siteConfig.links.lryanleGithub}
						target="_blank"
						rel="noreferrer"
						className="font-medium underline underline-offset-4"
					>
						GitHub
					</Link>
					.
				</p>
			</div>
		</footer>
	);
}

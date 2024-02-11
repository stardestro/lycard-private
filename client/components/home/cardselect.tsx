"use client";

import React, { useState } from "react";
import { Icons } from "@/components/icons";
import Spotlight, { SpotlightCard } from "@/components/home/spotlight";

import Link from "next/link";
import { Button, buttonVariants } from "@/components/ui/button";
import { cn } from "@/lib/utils";
import {
	Dialog,
	DialogContent,
	DialogDescription,
	DialogFooter,
	DialogHeader,
	DialogTitle,
	DialogTrigger,
} from "@/components/ui/dialog";
import { Input } from "@/components/ui/input";

type CardSelectProps = {
	children?: React.ReactNode;
	className?: string;
	props?: React.HTMLAttributes<HTMLElement>;
};

export default function CardSelect({ children, className = "", props }: CardSelectProps) {
	const [joinCode, setJoinCode] = useState<string>("");

	return (
		<Spotlight
			className={cn(
				className,
				"flex flex-col md:flex-row justify-center items-center gap-6 mx-auto group"
			)}
			{...props}
		>
			<SpotlightCard className="w-[80vw] h-max md:w-[22rem] md:h-[11rem]">
				<div className="flex items-center justify-center relative h-full bg-slate-50 dark:bg-slate-900 p-6 pb-8 rounded-[inherit] z-20 overflow-hidden">
					<div
						className="absolute bottom-0 translate-y-1/2 left-1/2 -translate-x-1/2 pointer-events-none -z-10 w-1/2 aspect-square"
						aria-hidden="true"
					>
						<div className="absolute inset-0 translate-z-0 bg-slate-200 dark:bg-slate-800 rounded-full blur-[80px]"></div>
					</div>
					<div className="flex flex-col items-center text-center">
						<div className="relative inline-flex">
							<div
								className="w-[40%] h-[40%] absolute inset-0 m-auto -translate-y-[10%] blur-3xl -z-10 rounded-full bg-blue-400 dark:bg-blue-600"
								aria-hidden="true"
							></div>
						</div>
						<div className="mb-5">
							<h2 className="text-xl text-primary dark:text-slate-200 font-bold mb-1">
								Explore Credit Cards
							</h2>
							<p className="text-sm text-muted-foreground dark:text-slate-500">
								View and add credit cards to your account and explore each benefit
								provided.
							</p>
						</div>
						<Link
							href="/cards"
							className={cn(
								buttonVariants({ variant: "default" }),
								"inline-flex justify-center items-center gap-2 whitespace-nowrap rounded-lg bg-slate-200 dark:bg-slate-800 hover:bg-slate-50 hover:dark:bg-slate-900 border border-slate-200 dark:border-slate-700 px-3 py-1.5 text-sm font-medium text-slate-800 dark:text-slate-300 focus-visible:outline-none focus-visible:ring focus-visible:ring-indigo-300 dark:focus-visible:ring-slate-600 transition-colors duration-150"
							)}
						>
							<span>View Cards</span>
							<Icons.create className="fill-slate-500 w-5 h-5" />
						</Link>
					</div>
				</div>
			</SpotlightCard>
			<SpotlightCard className="w-[80vw] h-max md:w-[22rem] md:h-[11rem]">
				<div className="flex items-center justify-center relative h-full bg-slate-50 dark:bg-slate-900 p-6 pb-8 rounded-[inherit] z-20 overflow-hidden">
					<div
						className="absolute bottom-0 translate-y-1/2 left-1/2 -translate-x-1/2 pointer-events-none -z-10 w-1/2 aspect-square"
						aria-hidden="true"
					>
						<div className="absolute inset-0 translate-z-0 bg-slate-200 dark:bg-slate-800 rounded-full blur-[80px]"></div>
					</div>
					<div className="flex flex-col items-center text-center">
						<div className="relative inline-flex">
							<div
								className="w-[40%] h-[40%] absolute inset-0 m-auto -translate-y-[10%] blur-3xl -z-10 rounded-full bg-blue-400 dark:bg-blue-600"
								aria-hidden="true"
							></div>
						</div>
						<div className="mb-5">
							<h2 className="text-xl text-primary dark:text-slate-200 font-bold mb-1">
								Search Merchants
							</h2>
							<p className="text-sm text-muted-foreground dark:text-slate-500">
								Search and explore merchants nearby and get recommend the best card to use.
							</p>
						</div>
						<Link
							href="/search"
							className={cn(
								buttonVariants({ variant: "default" }),
								"inline-flex justify-center items-center gap-2 whitespace-nowrap rounded-lg bg-slate-200 dark:bg-slate-800 hover:bg-slate-50 hover:dark:bg-slate-900 border border-slate-200 dark:border-slate-700 px-3 py-1.5 text-sm font-medium text-slate-800 dark:text-slate-300 focus-visible:outline-none focus-visible:ring focus-visible:ring-indigo-300 dark:focus-visible:ring-slate-600 transition-colors duration-150"
							)}
						>
							<span>Search Cards</span>
							<Icons.search className="fill-slate-500 w-5 h-5" />
						</Link>
					</div>
				</div>
			</SpotlightCard>
		</Spotlight>
	);
}

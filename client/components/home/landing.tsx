import React from 'react'
import { Icons } from '@/components/icons';
import { Meteors } from './meteor';
import CardSelect from './cardselect';
import { Badge } from '../ui/badge';

export default function Landing() {

  return (
    <div className="flex justify-center items-center flex-col my-16 h-full w-full">
      <div className="flex justify-center items-center flex-col gap-4 space-y-4">
        <span className="text-center text-primary font-bold tracking-tight text-[11vw] md:text-8xl flex flex-row justify-center items-center text-nowrap">
          <Icons.logo className="w-[11vw] h-[11vw] md:w-24 md:h-24" />
          <span className="py-3 bg-clip-text text-transparent bg-[linear-gradient(to_right,theme(colors.slate.800),theme(colors.red.950),theme(colors.stone.800),theme(colors.gray.800),theme(colors.pink.950),theme(colors.neutral.800),theme(colors.rose.950),theme(colors.zinc.800),theme(colors.slate.800))] dark:bg-[linear-gradient(to_right,theme(colors.slate.200),theme(colors.red.200),theme(colors.stone.200),theme(colors.gray.200),theme(colors.pink.200),theme(colors.neutral.200),theme(colors.rose.200),theme(colors.zinc.200),theme(colors.slate.200))] bg-[length:200%_auto] animate-gradient">LyCard</span>
        </span>
        <span className="text-center text-primary font-semibold tracking-normal text-3xl">{"Tomorrow's Benefits Today"}</span>
        <div className="flex justify-center items-center gap-2 flex-wrap">
          <Badge variant="secondary" className="text-sm px-3">250+ Cards Supported</Badge>
          <Badge variant="secondary" className="text-sm px-3">iOS & Desktop</Badge>
          <Badge variant="secondary" className="text-sm px-3">Blazingly Fast</Badge>
          <Badge variant="secondary" className="text-sm px-3">Intuitive</Badge>
          <Badge variant="secondary" className="text-sm px-3">100% Free</Badge>
        </div>
      </div>
      <CardSelect className="mt-16" />
      <Meteors number={10} />
    </div>
  )
}
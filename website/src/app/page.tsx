"use client";
import Image from "next/image";
import Link from "next/link";
import { Download } from "lucide-react";
import { FaGithub } from "react-icons/fa";
import Divider from "./(components)/Divider";

export default function Home() {
  return (
    <main className="min-h-screen w-full bg-white relative flex items-center justify-center gap-10 py-10">
      {/*  Diagonal Cross Grid Bottom Background */}
      <div
        className="absolute inset-0"
        style={{
          backgroundImage: `
        linear-gradient(45deg, transparent 49%, #e5e7eb 49%, #e5e7eb 51%, transparent 51%),
        linear-gradient(-45deg, transparent 49%, #e5e7eb 49%, #e5e7eb 51%, transparent 51%)
      `,
          backgroundSize: "40px 40px",
          WebkitMaskImage:
            "radial-gradient(ellipse 100% 80% at 50% 100%, #000 50%, transparent 90%)",
          maskImage:
            "radial-gradient(ellipse 100% 80% at 50% 100%, #000 50%, transparent 90%)",
        }}
      />
      {/* Footer */}
      <Link
        href="https://portfolio-itsmeprince.vercel.app/"
        target="_blank"
        rel="noopener noreferrer"
        className="absolute bottom-1 left-1/2 transform -translate-x-1/2 -translate-y-1/2 text-xs"
      >
        Made by @itsmeprinceyt
      </Link>

      {/* Main Content */}
      <div className="relative z-10 flex flex-col md:flex-row items-center gap-5  max-w-6xl w-full">
        {/* Logo */}
        <Link
          href="https://github.com/itsmeprinceyt/minus_plus_flutter/tree/main/release"
          target="_blank"
          rel="noopener noreferrer"
          className="w-full max-w-md"
        >
          <Image
            src="/logo.png"
            alt="App Logo"
            width={500}
            height={500}
            className="object-contain rounded-xl transition-transform duration-1000 hover:scale-110 animate-float"
          />
        </Link>

        {/* Glass Card Content */}
        <div className="w-full max-w-2xl bg-white/0 border border-white/20 backdrop-blur-md shadow-2xl  rounded-xl p-5">
          <div className="p-5 space-y-5">
            <h1 className="text-4xl font-bold tracking-tight">
              Minus Plus Counter
            </h1>

            <p className=" text-xs text-stone-700">
              Minus Plus Counter is a beautifully simple tally app with smart
              formatting and persistent storage.
              <br />
              <br />
              Tap the + button to count up or the - button to count down—your
              progress is automatically saved locally.
              <br />
              <br />
              When numbers get big (1,000+), they intelligently format to K, M,
              B, and more, keeping your display clean while showing exact counts
              below.
            </p>

            <div className="flex flex-wrap items-center md:items-start justify-center md:justify-start gap-2 text-white text-xs">
              <Link
                href="https://github.com/itsmeprinceyt/minus_plus_flutter/tree/main/release"
                target="_blank"
                rel="noopener noreferrer"
                className="inline-flex items-center gap-3 px-3 py-1.5 text-lime-950 rounded-md hover:text-lime-200 bg-linear-to-r from-lime-500 to-lime-600 border border-lime-600 hover:border-lime-500 shadow-xl hover:shadow-lime-600/30 shadow-lime-600/20 transition-all duration-300 "
              >
                <Download className="w-4 h-4" />
                Download
              </Link>

              {/*
              <Link
                href="https://www.youtube.com/watch?v=e7MSCbvnSZs"
                target="_blank"
                rel="noopener noreferrer"
                className="inline-flex items-center gap-3 px-3 py-1.5   rounded-md bg-linear-to-r from-red-700 to-red-900 border border-red-700 hover:border-red-600 shadow-xl hover:shadow-red-600/30 shadow-red-600/20 transition-all duration-300"
              >
                <LucidePlay className="w-4 h-4" />
                Watch Video
              </Link>
               */}

              <Divider />

              <Link
                href="https://github.com/itsmeprinceyt/minus_plus_flutter/tree/main/website"
                target="_blank"
                rel="noopener noreferrer"
                className="inline-flex items-center gap-3 px-3 py-1.5   rounded-md bg-linear-to-r from-stone-800 to-stone-900 border border-stone-800 hover:border-stone-700 shadow-xl hover:shadow-stone-600/30 shadow-stone-600/20 transition-all duration-300"
              >
                <FaGithub className="w-4 h-4" />
                Website Repository
              </Link>

              <Link
                href="https://github.com/itsmeprinceyt/minus_plus_flutter/tree/main/flutter"
                target="_blank"
                rel="noopener noreferrer"
                className="inline-flex items-center gap-3 px-3 py-1.5   rounded-md bg-linear-to-r from-stone-800 to-stone-900 border border-stone-800 hover:border-stone-700 shadow-xl hover:shadow-stone-600/30 shadow-stone-600/20 transition-all duration-300"
              >
                <FaGithub className="w-4 h-4" />
                App Repository
              </Link>
            </div>
          </div>
        </div>
      </div>
    </main>
  );
}

import type { Metadata } from "next";
import "./globals.css";
import { Suspense } from "react";
import Loader from "./(components)/Loader";

export const metadata: Metadata = {
  metadataBase: new URL("https://minus-plus-flutter.vercel.app/"),
  title: "Minus Plus – Simple Counter",
  description:
    "Minus Plus is a clean and simple Flutter-based counter app.",
  applicationName: "Minus Plus",
  authors: [
    { name: "ItsMe Prince", url: "https://github.com/itsmeprinceyt" },
  ],
  creator: "ItsMe Prince",
  keywords: [
    "Minus Plus app",
    "flutter app",
    "counter app"
  ],
  icons: {
    icon: "/logo.png",
  },
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en">
      <body className="antialiased select-none">
        <Suspense fallback={<Loader />}>
          {children}
        </Suspense>
      </body>
    </html>
  );
}

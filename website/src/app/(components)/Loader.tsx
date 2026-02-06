"use client";
import Spinner from "./Spinner";

export default function Loader() {
    return (
        <div
            className="z-50 absolute inset-0 flex items-center justify-center bg-cover bg-center bg-no-repeat"
            style={{ backgroundImage: "url('/background.jpg')" }}
        >
            <div className="relative flex items-center justify-center text-white gap-4 text-base bg-black/30 p-6 rounded-xl backdrop-blur-md shadow-xl">
                {/* Glowing Spinner Wrapper */}
                <div className="relative">
                    <div className="absolute inset-0 rounded-full blur-xl bg-blue-400 opacity-30 animate-ping" />
                    <Spinner />
                </div>

                {/* Animated Loading Text */}
                <span className="text-lg font-extralight tracking-wider animate-pulse">
                    Loading
                </span>
            </div>
        </div>
    );
}
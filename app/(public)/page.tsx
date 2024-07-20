import Link from "next/link";

export default function Home()
{
    return (
        <div className="flex flex-col gap-2 w-full">
            <h1 className="bg-emerald-400 p-2 text-center font-bold text-emerald-950 rounded-md text-lg">Markdown app</h1>
            <div className="flex flex-row justify-between mt-3">
                <Link className="bg-teal-800 p-2 rounded-lg text-teal-100 font-light text-lg hover:bg-teal-700 transition-all" href="/signup">singn up</Link>
                <Link className="bg-teal-800 p-2 rounded-lg text-teal-100 font-light text-lg hover:bg-teal-700 transition-all" href="/login">log in</Link>
            </div>
        </div>
    )
}
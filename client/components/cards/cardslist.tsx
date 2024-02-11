import * as React from "react";

interface Card {
  image: { type: string, value: string }
  name: { type: string, value: string }
  restaurant: { type: string, value: number }
  gas: { type: string, value: number }
  shopping_0: { type: string, value: number }
  travel: { type: string, value: number }
}

interface CardsListProps {
  cards: Card[];
  error: string | null;
}

export default function CardsList({ cards, error }: CardsListProps) {
  if (error) {
    return <div>Error: {error}</div>;
  }

  return (
    <div className="mr-4 flex flex-row flex-wrap items-center justify-start">
      
    </div>
  );
}

export async function getServerSideProps() {
  try {
    const response = await fetch("https://lycard.kintone.com/k/v1/records.json?app=2", {
      method: "GET",
      headers: {
        "X-Cybozu-API-Token": process.env.KINTONE_APIKEY ?? "",
      },
    });

    if (!response.ok) {
      throw new Error(`Failed to fetch data: ${response.status}`);
    }

    const data = await response.json();
    // Assuming data.records contains the array of cards
    return { props: { cards: data.records, error: null } };
  } catch (error) {
    console.error("Error:", error);
    return { props: { cards: [], error: error || 'Failed to load data' } };
  }
}

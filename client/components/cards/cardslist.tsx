import * as React from "react";

export default async function CardsList() {
	const staticData = await fetch("https://lycard.kintone.com/k/v1/records.json?app=2", {
		method: "GET",
		headers: {
			"X-Cybozu-API-Token": process.env.KINTONE_APIKEY ?? "",
		},
	})
		.then((response) => response.json())
		.then((data) => console.log(data))
		.catch((error) => console.error("Error:", error));



	return <div className="mr-4 flex flex-row flex-wrap items-center justify-start">
    {/* {await staticData.map((card) => (
      <div className="card">
        <h2>{card.name}</h2>
        <p>{card.description}</p>
        <p>{card.description}</p>
        <p></p>
        <p></p>
        <p></p>
      </div>
    ))} */}
  </div>;
}

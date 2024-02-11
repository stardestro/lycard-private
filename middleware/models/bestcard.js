const getBestCategory = async (subcategory) => {
  subcategory = subcategory.replace(/^mkpoicategory/, '');

  const categoryMap = {
    bakery: 'restaurant',
    brewery: 'restaurant',
    cafe: 'restaurant',
    foodMarket: 'restaurant',
    marina: 'restaurant',
    restaurant: 'restaurant',
    winery: 'restaurant',
    evCharger: 'gas',
    gasStation: 'gas',
    amusementPark: 'shopping_0',
    aquarium: 'shopping_0',
    atm: 'shopping_0',
    fitnessCenter: 'shopping_0',
    laundry: 'shopping_0',
    movieTheater: 'shopping_0',
    museum: 'shopping_0',
    nightlife: 'shopping_0',
    pharmacy: 'shopping_0',
    postOffice: 'shopping_0',
    stadium: 'shopping_0',
    store: 'shopping_0',
    theater: 'shopping_0',
    zoo: 'shopping_0',
    airport: 'travel',
    carRental: 'travel',
    hotel: 'travel',
    parking: 'travel',
    publicTransport: 'travel'
  };

  return categoryMap[subcategory] || 'none';
};

const getBestCard = async (category) => {
  const staticData = await fetch("https://lycard.kintone.com/k/v1/records.json?app=2", {
		method: "GET",
		headers: {
			"X-Cybozu-API-Token": process.env.KINTONE_APIKEY,
		},
	})
		.then((response) => response.json())
		.catch((error) => console.error("Error:", error));

  let maxVal = 0;
  let bestCard = null;
  const cat = getBestCategory(category);

  for (const record of staticData.records) {
    // Convert value to a number for comparison, since JSON values are strings
    const value = parseFloat(record[await cat]?.value || '0');

    if (value > maxVal) {
      maxVal = value;
      bestCard = record;
    }
  }

  return bestCard ? {
    name: bestCard.name.value,
    percent: maxVal,
  } : null;
};

module.exports = getBestCard;
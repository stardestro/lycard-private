
const OpenAI = require("openai");
require('dotenv').config()

const openai = new OpenAI({
	organization: process.env.OPENAI_ORG,
  apiKey: process.env.OPENAI_KEY
});

const getloc = async (image_path) => {
  const visionResult = await openai.chat.completions.create({
    model: "gpt-4-vision-preview",
    messages: [
			{
				role: "user",
				content: [
					{
						type: "text",
						text: "I need you to identify the level of severity of damage to the (main) vehicle in this image. I'll need you to provide a score of 0 through 10 (0 being no visible damage to the vehicle, 1 being minor damage like scratches, 5 being a few dents in the vehicle, and 10 being the vehicle is in some sort of crushed/totaled state). In addition, please provide a few key-words description of what you see (i.e. `'Minor dents to passanger door', 'glass broken on driver side window', ...`)., Please provide a response in the following json parsable format: `{score: 0-10, description: ['noticable vehicle defects', ...]}`. If no defects are found, return `{score: 0, description: []}`. Please only respond with the requested format and nothing else. Do not include any markdown (triple backtick + json or anything of the sort). Thank you!",
					},
					{
						type: "image_url",
						image_url: {
							url: new TextEncoder().decode(image_path),
						},
					},
				],
			},
		],
  })

  return visionResult.choices[0]?.message?.content;
};

module.exports = getloc;
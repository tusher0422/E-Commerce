require('dotenv').config();
const functions = require("firebase-functions");
const stripe = require("stripe")(process.env.STRIPE_SECRET_KEY); 
const cors = require("cors")({ origin: true });

exports.createCheckoutSession = functions.https.onRequest((req, res) => {
  cors(req, res, async () => {
    const { price, name } = req.body;

    try {
      const session = await stripe.checkout.sessions.create({
        payment_method_types: ["card"],
        mode: "payment",
        line_items: [{
          price_data: {
            currency: "usd",
            product_data: {
              name: name,
            },
            unit_amount: Math.round(price * 100),
          },
          quantity: 1,
        }],
        success_url: "http://localhost:5000/#/success",
        cancel_url: "http://localhost:5000/#/cancel",
      });

      res.status(200).json({ id: session.id });
    } catch (e) {
      res.status(400).send(`Error: ${e.message}`);
    }
  });
});

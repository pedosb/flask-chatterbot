from flask import Flask, render_template, request, json
from chatterbot import ChatBot
from chatterbot.trainers import ChatterBotCorpusTrainer

app = Flask(__name__)

meta_bot = ChatBot("English Bot")
meta_bot.set_trainer(ChatterBotCorpusTrainer)
meta_bot.train("data.detran",
               "chatterbot.corpus.portuguese.greetings")


@app.route("/")
def home():
    return render_template("index.html")

@app.route("/get", methods=['POST', 'GET'])
def get_raw_response():
    return_data = dict()
    return_data['text'] = str(meta_bot.get_response(request.json['text']))
    response = app.response_class(
        response=json.dumps(return_data),
        status=200,
        mimetype='application/json'
    )
    return response

if __name__ == "__main__":
    app.run(host='0.0.0.0')

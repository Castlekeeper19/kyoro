# Kyoro

Kyoro is an Engagement Management tool, designed to make keeping track of your remote teams easier. Integration with Slack to send surveys, receive responses and feedback. Responses are compiled and displayed in graph-form on the Kyoro Dashboard and other pages.

## Prerequisites:
Slack App with the following features / functionality:
- Incoming Webhooks
- Interactive Components
- Slash Commands
- Bots
- Permissions
Cloudinary API account

## Getting Started

## Slack App
Create a Slack App from the slack API to act as communication (surveys) and data collection (responses and anonymous feedback).

Add your Bot User OAuth Token to .env file, found in Slack App > Settings > Install App, example below
SLACK_TOKEN=xoxb-############-############-##################

Add a Webhook to Workspace
Then copy the webhook and add to .env file, example below
```env
SLACK_WEBHOOK_URL=https://hooks.slack.com/services/########/########/###############
```

Paste the following into Request URL field in Interactivity & Shortcuts tab
```
https://kyoro-manager.herokuapp.com/api/v1/user_answers
```

Create a Slash Command to collect Anonymous Feedback
Create New Command called /feedbackbox or whatever you'd like and paste the following into Reauest URL field in the edit page
```
https://kyoro-manager.herokuapp.com/api/v1/user_answers
```

## Cloudinary
Add cloudinary API Environment variable to .env file, example below:
```env
CLOUDINARY_URL=cloudinary://###########:##################@########
```

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.


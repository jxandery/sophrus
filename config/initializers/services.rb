require 'slack-notifier'

SLACK = Slack::Notifier.new(ENV['SLACK_WEBHOOK_URL'])

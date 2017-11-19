require_relative 'embed_objects/issue_embeds'
require_relative 'dispatcher'

module RedmineDiscord
    class EventListener < Redmine::Hook::Listener
        def initialize
            @dispatcher = DiscordWebhookDispatcher.new
        end

        def controller_issues_new_after_save(context={})
            issue = context[:issue]
            return if issue.is_private?

            project = issue.project
            embed_object = NewIssueEmbed.new context

            @dispatcher.dispatch embed_object, project
        end
    end
end
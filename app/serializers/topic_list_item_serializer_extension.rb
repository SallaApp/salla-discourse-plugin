# frozen_string_literal: true

TopicListItemSerializer.class_eval do
  attributes :category,
             :topic_creator,
             :cooked,
             :first_post_details
	def category
    {
      id: category_id,
      name: object.category&.name,
      only_admin_can_post: object.category&.groups&.exists?(name: "admins"),
      emoji: "https://community.salla.com/forum/#{category_id}.png"
    }
  end

  def topic_creator
    {
      id: object.user&.id,
      username: object.user&.username,
      avatar: object.user&.avatar_template,
      topic_title: object.title,
      name: object.user&.name
    }
  end

	def cooked
    object&.first_post&.cooked
  end

	def first_post_details
    {
      post_id: object&.first_post&.id,
      # bookmark_id: bookmark_id_for_first_post,
      is_post_liked: true,
      is_post_bookmarked: true
    }
  end

	private

		def is_post_liked?
			DiscourseReactions::ReactionUser
			.where(user_id: scope.user&.id, post_id: object&.first_post&.id)
			.exists?
		end

		def is_post_bookmarked?
			object&.first_post&.bookmarks&.where(user_id: scope.user&.id)&.last.present?
		end

		def bookmark_id_for_first_post
			bookmark = object&.first_post&.bookmarks&.where(user_id: scope.user&.id).last
			bookmark&.id
		end
end
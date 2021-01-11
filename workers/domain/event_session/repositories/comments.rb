# frozen_string_literal: true

module IndieLand
  module Repository
    # Repository for Comments
    class Comments
      def self.comment(event_id, comment)
        CommentEntityBuilder.rebuild_entity Database::CommentOrm.create(event_id: event_id, comment: comment)
      end

      def self.find_all(event_id)
        CommentsEntityBuilder.rebuild_entity(event_id, Database::CommentOrm.where(event_id: event_id).all)
      end
    end

    # A class for building Comments entity
    class CommentsEntityBuilder
      def self.rebuild_entity(event_id, comment_records)
        comment_entities = CommentEntityBuilder.rebuild_entities(comment_records)
        Entity::Comments.new(
          event_id: event_id,
          comments: comment_entities
        )
      end
    end

    # A class for building Comment entity
    class CommentEntityBuilder
      def self.rebuild_entities(comment_records)
        return nil unless comment_records

        comment_records.map do |comment_record|
          rebuild_entity comment_record
        end
      end

      def self.rebuild_entity(comment_record)
        Entity::Comment.new(
          event_id: comment_record.event_id,
          comment: comment_record.comment
        )
      end
    end
  end
end

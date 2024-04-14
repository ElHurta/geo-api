class Api::V1::CommentsController < ApplicationController
    def create
        @feature = Feature.find_by(id: params[:feature_id])

        if @feature
            @comment = @feature.comments.build(comment_params)

            if @comment.save
                render json: @comment, status: :created
            else
                render json: { errors: @comment.errors.full_messages }, status: :unprocessable_entity
            end
        else
            render json: { error: 'Feature not found' }, status: :not_found
        end
    end

    private
    def comment_params
        params.require(:comment).permit(:body)
    end
end
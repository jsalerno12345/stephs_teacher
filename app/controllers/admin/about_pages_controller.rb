module Admin
  class AboutPagesController < ApplicationController
    def edit
      @about_page = AboutPage.first_or_create
    end

    def update
      @about_page = AboutPage.first
      if @about_page.update(about_page_params)
        redirect_to edit_admin_about_page_path, notice: "Updated successfully!"
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def about_page_params
      params.require(:about_page).permit(:content)
    end
  end
end

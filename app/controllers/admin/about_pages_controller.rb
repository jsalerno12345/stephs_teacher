module Admin
  class AboutPagesController < Admin::BaseController
    def edit
      @about_page = AboutPage.instance
    end

    def update
      @about_page = AboutPage.instance
      if @about_page.update(about_page_params)
        redirect_to admin_dashboard_path, notice: "About page updated!"
      else
        render :edit
      end
    end

    private

    def about_page_params
      params.require(:about_page).permit(:content)
    end
  end
end

require 'spec_helper'

describe 'User' do
  before do
    @post = Post.create(title: "This is a title!", content: "This is some content...")
    @user = mock(:user, :posts => mock(:Post, :title => "Some shit", :content => "Even more bullshit"))
    visit root_path
  
  end
  context "on homepage" do
    before do
    end
    it "sees a list of recent posts titles" do
      page.should have_content("This is a title!")
      # given a user and a list of posts
      # user visits the homepage
      # user can see the posts titles
    end
    it "can not see bodies of the recent posts" do
      page.should_not have_content("This is some content...")
      # given a user and a list of posts
      # user visits the homepage
      # user should not see the posts bodies
    end
    it "can click on titles of recent posts and should be on the post show page" do
      click_link(@post.title)
      current_path.should eq post_path(@post)
      # given a user and a list of posts
      # user visits the homepage
      # when a user can clicks on a post title they should be on the post show page
    end
    it "can not see the edit link" do
     page.should_not have_link("Edit")
    end
    it "can not see the delete link" do
      page.should_not have_link("Delete")
    end
  end

  context "post show page" do
    before do
      click_link(@post.title)
    end
    it "sees title and body of the post" do
      page.should have_content("This is a title!")
      page.should have_content("This is some content...")
    end
    it "can not see the edit link" do
      page.should_not have_link("Edit")
    end
    it "can not see the published flag" do
      page.should_not have_content("Published:")
    end
    it "can not see the Admin homepage link" do
      page.should_not have_content("Admin welcome page")
    end
  end
end

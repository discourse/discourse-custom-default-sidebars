# frozen_string_literal: true

DiscourseCustomDefaultSidebars::Engine.routes.draw do
  get "/examples" => "examples#index"
  # define routes here
end

Discourse::Application.routes.draw do
  mount ::DiscourseCustomDefaultSidebars::Engine, at: "discourse-custom-default-sidebars"
end

module SnlAdmin
  class UserPresenter < SimpleDelegator
    attr_reader :user
    include ActionView::Helpers::NumberHelper

    def initialize(user)
      super(user)
      @user = user
    end

    def public_name
      ("#{user.firstname} #{user.lastname}").strip
    end

    def confirmation_status
      css, status = if user.confirmed?
        ['text-success', I18n.t('confirmed')]
      else
        ['text-warning', I18n.t('unconfirmed')]
      end
      "<span class='#{css}'>#{status}</span>".html_safe
    end

    def activation_status
      css, status = if user.activated?
        ['text-success', I18n.t('active')]
      else
        ['text-warning', I18n.t('inactive')]
      end
      "<span class='#{css}'>#{status}</span>".html_safe
    end

    def role_name
      I18n.t(user.role.to_s).humanize
    end

    def mobile
      if user.mobilenumber.present?
        html = "<abbr title='#{SnlAdmin.user_class.human_attribute_name(:mobilenumber)}'>M:</abbr>"
        html << " #{user.mobilenumber}<br>"
      end.to_s.html_safe
    end

    def city
      "#{user.postal_address}<br>".html_safe if user.postal_address.present?
    end

    def license_name
      "#{License.model_name.human}: #{user.license.name.humanize}"
    end

    def ceiling
      "#{SnlAdmin.user_class.human_attribute_name(:fixed_ceiling)}: #{user.fixed_ceiling}"
    end

    def characters_changed
      user.num_characters_changed
    end

    def pay
      number_to_currency PayCalculator.earnings_for(user)
    end

    def paid_to_date
      paid = number_to_currency(user.paid_to_date.to_i)
      "#{SnlAdmin.user_class.human_attribute_name(:paid_to_date)}: #{paid}"
    end

    def unpaid_balance
      earnings = PayCalculator.earnings_for(user).to_i
      unpaid_balance = number_to_currency(earnings - user.paid_to_date.to_i)
      "#{I18n.t(:unpaid_balance, year: Date.today.year)}: #{unpaid_balance}"
    end
  end
end

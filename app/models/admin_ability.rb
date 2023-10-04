class AdminAbility
    include CanCan::Ability
    def initialize(admin)
        if admin
            can :read, [AdminHome]
            if admin.role? :administrator
                can :manage, :all
            elsif admin.role? :operator
                can :manage, :all
                cannot :delete, [Operator]
            elsif admin.role? :exporter
                can :manage,  [User, Report]
            elsif admin.role? :reader
                can :read, :all
                cannot :read, [Operator]
            end
        else
            cannot :manage, :all
        end
    end
end

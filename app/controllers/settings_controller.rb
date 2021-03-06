class SettingsController < ApplicationController
	def changeRestriction
    # ONLY HAPPENS FIRST UPDATE
    if(!Restriction.first)
      Restriction.create!(grades: 9, floors:"", full_buildings:"")
    end

    # GETS CHECKBOX VALUES
    restricted_floors = ""
    for i in 1..20
      counter_floor = 'floor' + i.to_s

      if params['floor0']
        restricted_floors = "none,"
        break
      end
      
      if(params[counter_floor])
        restricted_floors += (params[counter_floor]+',')
      end
    end

    if(params[:grade])
      Restriction.first.update_attribute(:grades, params[:grade])
    end

    if(restricted_floors != "") 
      Restriction.first.update_attribute(:floors, restricted_floors)
    end

    # CHECKS IF PASSWORD IS INCORRECT  - NOT FUNCTIONAL
    # if(params[:current_password] != "" && params[:current_password] != ENV["PASSWORD"])
    #   redirect_to '/index', notice: "error"
    #   return
    # end


    # if(params[:current_password] != ENV["PASSWORD"] && params[:new_password] == params[:again_password] && params[:new_password] != "")
    #   ENV["PASSWORD"] = params[:new_password]
    # end

    redirect_to '/index', notice: "Settings Updated!"
  end
end

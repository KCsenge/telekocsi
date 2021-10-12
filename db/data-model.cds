namespace my.namespace;

entity member
{
    key id : UUID
        @Core.Computed;
    first_name : String(50) not null;
    last_name : String(50) not null;
    email : String(255) not null;
    contact_number : Integer not null;
    driving_licence_number : String(50);
    driving_licence_valid_from : Date;
}

entity car
{
    key id : UUID
        @Core.Computed;
    name : String(50) not null;
    make : String(50) not null;
    model : String(50) not null;
    make_year : Integer not null;
    comfort_level : Integer not null;
    car_registration_number : String(50) not null;
    car_color : String(50) not null;
}

entity member_car
{
    key id : UUID
        @Core.Computed;
    car_id: Association[1..*] to car on car_id.id = car_id;
    member_id: Association[1..*] to member on member_id.id = member_id;
}

entity member_preference
{
    key member_id: Association[1] to member { id };
    is_smoking_allowed : Boolean not null;
    is_pet_allowed : Boolean not null;
    chitchat_preference_id : Association[0..1] to chitchat_preference on chitchat_preference_id.id = chitchat_preference_id;
    music_preference_id : Association [0..1] to music_preference on music_preference_id.id = music_preference_id;
}

entity music_preference
{
    key id : UUID
        @Core.Computed;
    description : String(50) not null;
}

entity chitchat_preference
{
    key id : UUID
        @Core.Computed;
    description : String(50) not null;
}

entity ride
{
    key id : UUID
        @Core.Computed;
    member_car_id : UUID not null;
    created_on : Date not null;
    travel_start_time : Date not null;
    destination_city_id : UUID not null;
    seats_offered : Integer not null;
    contribution_per_head : Integer not null;
    luggage_size_id : Association[1] to ride on luggage_size_id.id = luggage_size_id;
    source_city_id : Association to one city;
}

entity luggage_size
{
    key id : UUID
        @Core.Computed;
    description : String(50) not null;
}

entity city
{
    key id : UUID
        @Core.Computed;
    city_name : String(50) not null;
    state : String(50) not null;
    country : String(50) not null;
}

entity request
{
    key id : UUID
        @Core.Computed;
    requester_id : UUID not null;
    enroute_city_id : UUID;
    created_on : Date not null;
    request_status_id : UUID not null;
    ride_id : Association[1] to ride on ride_id.id = ride_id;
}

entity enroute_city
{
    key id : UUID
        @Core.Computed;
    ride_id : UUID not null;
    city_id : UUID not null;
    order_from_source : Integer not null;
    prorated_contribution : Integer not null;
}

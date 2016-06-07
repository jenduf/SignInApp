//
//  Constants.swift
//  SunSignIn
//
//  Created by Jennifer Duffey on 3/28/16.
//  Copyright © 2016 Jennifer Duffey. All rights reserved.
//

import UIKit

public struct Constants
{
    // API URL
    public static let API_URL = "http://sunsignapp.com/signup/json/"
    public static let NPI_URL = "https://npiregistry.cms.hhs.gov/api/?"
    
    // API CALL ENDPOINTS
    struct APIEndpoints
    {
        static let API_ENDPOINT_LOGIN = "login"
        static let API_ENDPOINT_FORGOT_PASSWORD = "forget_password"
        static let API_ENDPOINT_DELETE_PARTNER = "delete_part"
        static let API_ENDPOINT_UPDATE_PARTNER = "update_part_data"
        static let API_ENDPOINT_GET_TITLES = "get_title_list"
        static let API_ENDPOINT_GET_DEPARTMENTS = "get_depart_list"
        static let API_ENDPOINT_GET_PRODUCTS = "get_product_list"
        static let API_ENDPOINT_GET_COMPANY_DETAILS = "get_company_details"
        static let API_ENDPOINT_GET_COMPANY_LIST = "get_company_list"
        
        static let APP_GROUP_IDENTIFIER = "group.graylinctech.sunsignapp"
    }
    
    // HTTP REQUESTS
    struct HTTPRequestMethods
    {
        static let HTTP_GET = "GET"
        static let HTTP_POST = "POST"
    }
    
    // CONTROLLERS 
    public static let PROGRAM_INFO_VIEW_CONTROLLER = "ProgramInfoViewController"
    public static let EVENT_LIST_VIEW_CONTROLLER = "EventListViewController"
    
    // CELL IDENTIFIERS
    struct CellIdentifiers
    {
        static let MENU_CELL_IDENTIFIER = "MenuCellIdentifier"
        static let EVENT_CELL_IDENTIFIER = "EventCellIdentifier"
        static let PARTICIPANT_CELL_IDENTIFIER = "ParticipantCellIdentifier"
        static let PARTICIPANT_REPORT_CELL_IDENTIFIER = "ParticipantReportCellIdentifier"
    }
    
    // COLORS
    struct Colors
    {
        static let COLOR_BACKGROUND_GRADIENT_TOP = "424057"
        static let COLOR_BACKGROUND_GRADIENT_BOTTOM = "3a6ba1"
        static let COLOR_INDICATOR_ACTIVE = "ffd000"
        static let COLOR_TEXTFIELD_ACTIVE = "147bd0"
        static let COLOR_ALERT_BACKGROUND = "3a6aa0"
        static let COLOR_ALERT_BUTTON = "f5f5f5"
    }
    
    // IMAGES
    struct Images
    {
        static let IMAGE_DROPDOWN = "dropdown"
        static let IMAGE_DROPDOWN_BACKGROUND = "dropdown-item-bg"
    }
    
    
    // LAYOUT
    struct Layout
    {
        static let TOP_BUTTON_WIDTH: CGFloat = 135.5
        static let TOP_BUTTON_LEFT: CGFloat = 80
        static let SMALL_PADDING: CGFloat = 5.0
        static let VERTICAL_PADDING: CGFloat = 10.0
        static let DIVIDER_HEIGHT: CGFloat = 3.0
        static let CORNER_RADIUS: CGFloat = 10.0
        static let SIDE_PADDING: CGFloat = 30.0
        static let TOP_PADDING: CGFloat = 25.0
        static let CONTAINER_SPACING: CGFloat = 20.0
        static let TEXT_FIELD_HEIGHT: CGFloat = 30.0
        static let CONTAINER_PADDING: CGFloat = 20.0
        static let TEXT_FIELD_PADDING: CGFloat = 5.0
        static let DROPDOWN_ROW_HEIGHT: CGFloat = 45.0
        static let DROPDOWN_VIEW_HEIGHT: CGFloat = 90.0
        static let ALERT_VIEW_HEIGHT: CGFloat = 130.0
        static let ALERT_VIEW_WIDTH: CGFloat = 250.0
        static let ALERT_BUTTON_HEIGHT: CGFloat = 36.0
        static let ALERT_SEPARATOR: CGFloat = 1.0
    }
    
    // STRINGS
    struct Strings
    {
        static let ALERT_MESSAGE_REQUIRED_FIELDS = "All fields and a receipt image are required."
        static let ALERT_MESSAGE_FIELDS_MISSING = "Please fill out all required fields."
        static let ALERT_MESSAGE_SAVE_PROMPT = "What type of report do you want?"
    }
    
    static let ANIMATION_DURATION = 0.3
    
    static let USER_DICT_KEY: String = "UserDictKey"
}

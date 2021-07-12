//
//  ApisSuffix.swift

//
//  Created by promatics on 6/19/20.
//  Copyright © 2020 Temp. All rights reserved.
//

import Foundation

enum APISuffix {

    case userSignUp
    case login
    case productListing
    case serviceListing
    case BookingsListing
    case ProductDetails
    case hitCountry
    case hitCity
    case updateUserProfile
    case getUserDetail
    case checkexist
    case changePassword
    case editAddress
    case addAddress
    case AddressListing
    case deleteAddress
    case defaultAddress
    case getdefaultAddress
    case cancelOrderList
    case OtpVerification
    case InProgressOrder
    case DelieveredOrder
    case CancelOrderItem
    case addtocart
    case addtocartAgain
    case addtowishlist
    case AddAlbumsListing
    case WishlistListing
    case termsandConditions
    case AlbumListing
    case serviceSubCategories
    case AlbumDetails
    case EditAlbum
    case DeleteAlbum
    case cartListing
    case RemovefromCart
    case Checkout
    case addCard
    case OrdersDetail
    case addAppointment
    case addquotation
    case QuotationsRequestsListing
    case QuotationDetails
    case IssueQuotationDetails
    case ProductCategories
    case orderManageList
    case createDiscount
    case DiscountListings
    case AddProducttoCollection
    case CollectionsListing
    case CollectionListwithPagination
    case DeleteCollection
    case removeProductfromCollection
    case CollectionProducts
    
    
    
    
    // ----------------------------------------------------------------------
    case professtionalSignUp
    case profrsstionalGetAllProducts
    case getUserProfileDetails
    case editProfesstionalProfile
    
    case uploadImage
    case getAllCities
    case branchTypes
    case branchCategories
    case serviceCategories
    
    
    case getProject
    case getPaginatedProjects
    case getProfStyes
    case getProfCategory
    case getProfBranch
    case getProfWithoutPagiantion
    case addProfproject
    case getProjectDetail
    
    case addBranch
    case getBranchList
    case uploadProfile
    case getBranchDetails
    case editProfessionalBranch
    
    case getStaffList
    case getPrevilaegeList
    case addPreviledge
    case addStaff
    case editStaff
    
    case getAllProducts
    case getProductDetails
    case getServiceDetails
    case getServiceList
    case getServiceCategory
    
    case profesionalquotationsRequestsListing
    
    case getProfessionalBookingList
    
    case getStyles
    case quotationRqstAction
    case acceptRejectAppointment
    
    case getDesignationList
    case sortByProducts
    
    case recentlyProfessionals
    case allProfessionals
    
    case getSubCateById
    case searchInServiceCategory
    case addProfService
    case getProjBySubId
    case getProfProjects
    case addIssueQuotation
    case ModifyIssueQuotation
    
    case add_product
    case add_vendor
    case producttype
    case inventory
    case collection
    case ProductsWithoutPagiantion

    func getDescription() -> String
    {
        switch self {
        case .userSignUp:
            return "register"
        case .login:
            return "login"
        case .productListing:
            return "products"
        case .serviceListing:
            return "getAllServicesList"
        case .hitCountry :
            return "getCountries"
        case .hitCity:
            return "getStatesOfCountry"
        case .updateUserProfile :
            return "updateProfile"
        case .getUserDetail:
            return "getUserDetails"
        case .checkexist:
            return "emailAlreadyExist"
        case .changePassword:
            return "changeOldPassword"
        case .editAddress:
            return "editOldAddress"
        case .addAddress:
            return "addNewAddress"
        case .AddressListing:
            return "addressList"
        case .deleteAddress:
            return "deleteAddresses"
        case .defaultAddress:
            return "setAddressDefault"
        case .cancelOrderList:
            return "getCancelledOrderList"
        case .OtpVerification:
            return "otpVerification"
        case .InProgressOrder:
            return "customer/getOrderItems/accToStatus"
        case .DelieveredOrder:
            return "getOrderPurchasedByUser"
        case .ProductDetails:
            return "product/details"
        case .addtocart:
            return "addToCart"
        case .addtowishlist:
            return "addRemoveFromWishlist"
        case .AddAlbumsListing:
            return "addUserAlbum"
        case .WishlistListing:
            return "myWishlist"
        case .termsandConditions:
            return "getGeneralContent"
        case .AlbumListing:
            return "getMyAlbumList"
        case .serviceSubCategories:
            return "serviceSubCategories"
        case .AlbumDetails:
            return "getAlbumDetails"
        case .EditAlbum:
            return "EditUserAlbum"
        case .DeleteAlbum:
            return "deleteSingleAlbum"
        case .cartListing:
            return "cartDetailsNew"
        case .RemovefromCart:
            return "updateCartItemQty"
        case .Checkout:
            return "orderCheckout"
        case .getdefaultAddress:
            return "getDefaultAddress"
        case .CancelOrderItem:
            return "cancelOrder"
        case .addCard:
            return "addNewCard"
        case .OrdersDetail:
            return "getMyOrderDetails"
        case .BookingsListing:
            return "booking/getMyBookingList"
        case .addAppointment:
            return "booking/addBooking"
        case .addquotation:
            return "requestQuotation"
        case .QuotationsRequestsListing:
            return "quotationRequestList"
        case .QuotationDetails:
            return "getQuotationDetails"
        
     // --------------------------------------------------------------------------
        case .professtionalSignUp:
            return "registerProfessional"
        case .profrsstionalGetAllProducts:
            return "getAllProducts"
        case .getUserProfileDetails:
            return "getUserProfileDetails"
        case .uploadImage:
            return "uploadImage"
        case .getAllCities:
            return "getAllCities"
        case .branchTypes:
            return "brandTypes"
        case .branchCategories:
            return "brandCategories"
        case .serviceCategories:
            return "serviceSubCategories"
        case .editProfesstionalProfile:
            return "editProfessionalProfile"
            
        
        case .getProject:
            return "getProfessionalProjectsWithoutPagination"
        case .getProfStyes:
            return "getStyleListing"
        case .getProfCategory:
            return "getCatAndSubCat"
        case .addProfproject:
            return "addProfessionalProject"
        case .getProfBranch:
            return "getProfessionalBranchList"
        case .getPaginatedProjects:
            return "getProfessionalProjects"
        case .getProjectDetail:
            return "getProjectById"
      
        case .addBranch:
            return "addProfessionalBranch"
        case .getBranchList:
            return "getBranchList"
        case .uploadProfile:
            return "uploadProfile"
        case .getBranchDetails:
            return "getBranchDetails"
        case .editProfessionalBranch:
            return "editProfessionalBranch"
      
        case .getStaffList:
            return "getProfessionalStaffList"
        case .getPrevilaegeList:
            return "getAllPrivilegeList"
        case .addPreviledge:
            return "addStaffPrivileges"
        case .addStaff:
            return "addProfessionalStaffs"
        case .editStaff:
            return "editProfessionalStaffs"
            
        case .getAllProducts:
            return "getAllProducts"
   
        case .getProductDetails:
            return "product/details"
        
   
        
        case .getServiceList:
            return "getProfessionalServicesList"
        case .getServiceDetails:
            return "getProfessionalServicesDetails"
        
        case .getServiceCategory:
            return "getCatAndSubCat"
        
       
        case .profesionalquotationsRequestsListing:
            return "professional/quotationRequestList"
        
        case .getProfessionalBookingList:
            return "professional/getMyBookingList"
        case .getStyles:
            return "getStyleListing"
        case .quotationRqstAction:
            return "professional/quotationAction"
        case .acceptRejectAppointment:
            return "professional/bookingAction"
        case .getDesignationList:
            return "designations"
        case .sortByProducts:
            return "products"
        case .recentlyProfessionals:
            return "nonlogged/professionals"
        case .getSubCateById:
            return "getSubcategoriesById"
        case .searchInServiceCategory:
            return "serviceCategories/search"
        case .addProfService:
            return "AddProfessionalService"
        case .getProjBySubId:
            return "getProjectsAccordingToSubCat"
        case .allProfessionals:
            return "allProfessionals"
        case .getProfProjects:
            return "customer/getProfessionalProjects"
        case .addIssueQuotation:
            return "professional/issueQuotation/add"
        case .IssueQuotationDetails:
            return "issueQuotation/details"
        case .ModifyIssueQuotation:
            return "issueQuotation/modify"
            
            
            
            
            
        case .ProductCategories:
            return "product/categories"
        case .add_product:
            return "add_product"
        case .add_vendor:
            return "getProductTypeVendor"
        case .producttype:
            return "get/product/types"
        case .inventory:
            return "getInventoryList"
        case .collection:
            return "user/product/collection"
        case .orderManageList:
            return "getOrderItems/accToStatus"
        case .addtocartAgain:
            return "repeat/order"
        case .getProfWithoutPagiantion:
            return "getAll/professionals/withoutPagination"
            
            
        case .ProductsWithoutPagiantion:
            return "getAllProductsWithoutPagination"
        case .createDiscount:
            return "professional/discounts/add"
        case .DiscountListings:
            return "professional/discounts"
        case .AddProducttoCollection:
            return "addProductToCollection"
        case .CollectionsListing:
            return "getAllProductCollection"
        case .CollectionListwithPagination:
            return "getAllProductCollectionWithPagination"
        case .DeleteCollection:
            return "removeCollection"
        case .CollectionProducts:
            return "getProductsFromCollection"
        case .removeProductfromCollection:
            return "removeProductFromCollection"
        }
    }
}


enum URLS {
    
    case baseUrl
    case productImgUrl(String)
    case profileImageUrl(String)
    case baseUrlProfileDetail
    case certificateImageUrl(String)
    case albumImageUrl(String)
    case projectImageUrl(String)
    case serviceImageUrl(String)
    case ServiceImgUrl(String)
    case QuotationImgUrl(String)
    
    func getDescription() -> String {
        
        switch self {
            
        case .baseUrl :
            return "https://developers.promaticstechnologies.com:3001/"

        case .productImgUrl(let fileName):
            return "https://developers.promaticstechnologies.com/dreeshah_apis/public/SellerProductImages/\(fileName)"
            
        case .ServiceImgUrl(let fileName):
            return "https://developers.promaticstechnologies.com/dreeshah_apis/public/ProfessionalServices/\(fileName)"
            
        case .profileImageUrl(let fileName):
            return "https://developers.promaticstechnologies.com/dreeshah_apis/public/userProfile/\(fileName)"
            
        case .baseUrlProfileDetail:
           return "https://developers.promaticstechnologies.com:3003/"
            
        case .albumImageUrl(let fileName):
          return"https://developers.promaticstechnologies.com/dreeshah_apis/public/userAlbum/\(fileName)"
            
        case .certificateImageUrl(let fileName):
            return "https://developers.promaticstechnologies.com/dreeshah_apis/public/professionalData/\(fileName)"
        case .projectImageUrl(let fileName):
            return "https://developers.promaticstechnologies.com/dreeshah_apis/public/ProfessionalProject/\(fileName)"
        case .serviceImageUrl(let fileName):
            return "https://developers.promaticstechnologies.com/dreeshah_apis/public/ProfessionalServices/\(fileName)"
            
        case .QuotationImgUrl(let fileName):
            return "https://developers.promaticstechnologies.com/dreeshah_apis/public/quotationImages/\(fileName)"
        }
        
    }
}




class UnifonicSmsGateway {
    
    var messageBody: String = ""
    let recipient: String
    let appSid: String = "evxaORfSlxgB7t3_NbAGclushgrQPl"
        
    
    init(otp: String , recipient: String) {
        self.messageBody = "Dear user, " + "\n" + otp + " is your one time password(OTP)." + "\n" + "Please enter the otp to proceed." + "\n" + "Thank you," + "\n" + "Team TAJR."
        self.recipient = recipient
    }
    
    deinit {
        print(#file , "UniFormSmsgateway Destructed")
    }
}

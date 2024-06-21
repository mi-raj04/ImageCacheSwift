//
//  ImageCollectionModel.swift
//  ImageCacherGrid
//
//  Created by mind on 15/04/24.
//

import Foundation

struct ImageData:Codable, Equatable {
    var id = UUID()
    var image:[ImageCollection]
}

// MARK: - ImageCollection
struct ImageCollection:Codable, Equatable {
    let id, slug: String?
    let alternative_slugs: AlternativeSlugs?
    let created_at, promoted_at: String?
    let width, height: Int?
    let color, blur_hash: String?
    let description: String?
    let alt_description: String?
    let breadcrumbs: [Breadcrumb]?
    let urls: Urls?
    let links: ImageCollectionLinks?
    let likes: Int?
    let liked_by_user: Bool?
    let current_user_collections: [String?]?
 //   let sponsorship: String?
    let asset_type: String?
}

// MARK: - AlternativeSlugs
struct AlternativeSlugs:Codable, Equatable {
    let en, es, ja, fr: String?
    let it, ko, de, pt: String?
}
// MARK: - Breadcrumb
struct Breadcrumb:Codable, Equatable {
    let slug, title: String?
    let index: Int?
    let type: String?
}

// MARK: - ImageCollectionLinks
struct ImageCollectionLinks:Codable, Equatable {
    let linksSelf, html, download, download_location: String?
}

// MARK: - Urls
struct Urls:Codable, Equatable {
    let raw, full, regular, small: String?
    let thumb, small_s3: String?
}

// MARK: - UserLinks
struct UserLinks:Codable, Equatable {
    let html, photos, likes: String?
    let portfolio, following, followers: String?
}

// MARK: - ProfileImage
struct ProfileImage:Codable, Equatable {
    let small, medium, large: String?
}

// MARK: - Social
struct Social:Codable, Equatable {
    let instagram_username: String?
    let portfolio_url: String?
    let twitter_username: String?
    let paypal_email: String?
}

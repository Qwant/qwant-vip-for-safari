//
//  SearchEngine.swift
//  Qwant for Safari (iOS)
//
//  Created by Jerome Boursier on 19/07/2022.
//

import Foundation

struct SearchEngine: Codable {
    let engine: String
    let query: String
    let client: String
    let source: String

    func isOriginatingFromApple(_ url: URL) -> Bool {
        source == url.valueFor(queryParam: client)
    }

    func userQuery(_ url: URL) -> String {
        url.valueFor(queryParam: query) ?? ""
    }
}

private extension URL {
    func valueFor(queryParam: String) -> String? {
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: false) else {
            return nil
        }

        return components
            .queryItems?
            .first { $0.name == queryParam }?
            .value?
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
}

// July 2022
// Google ->        google.com/search       ? q=test & client=safari    & rls=en        & ie=UTF-8      & oe=UTF-8
// Yahoo ->         search.yahoo.com/search ? p=test & fr=aaplw         & ei=utf-8
// Bing ->          bing.com/search         ? q=test & form=APMCS1      & PC=APMC
// Duckduckgo ->    duckduckgo.com/         ? q=test & t=osx            & ia=definition
// Ecosia ->        ecosia.org/search       ? q=test & tts=st_asaf_macos

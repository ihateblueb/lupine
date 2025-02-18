//
//  HttpClient.swift
//  Lupine
//
//  Created by blueb on 2/17/25.
//

import Alamofire
import Foundation

class HttpClient {
	enum StatusCodeMeaning {
		case Information
		case Success
		case Redirection
		case ClientError
		case ServerError
		case Nonstandard
		case Unknown
	}

	public func defineStatusCode(code: Int) -> StatusCodeMeaning {
		if code >= 100 && code < 200 {
			return StatusCodeMeaning.Information
		} else if code >= 200 && code < 300 {
			return StatusCodeMeaning.Success
		} else if code >= 300 && code < 400 {
			return StatusCodeMeaning.Redirection
		} else if code >= 400 && code < 500 {
			return StatusCodeMeaning.ClientError
		} else if code >= 500 && code < 600 {
			return StatusCodeMeaning.ServerError
		} else if code > 600 {
			return StatusCodeMeaning.Nonstandard
		} else {
			return StatusCodeMeaning.Unknown
		}
	}

	struct EmptyPost: Encodable {}

	public func post(
		url: String, body: Encodable = EmptyPost(),
		encoder: ParameterEncoder = JSONParameterEncoder.default,
		contentType: String? = "application/json"
	) -> DataRequest {
		print("HttpClient POST \(url) [-->]: \(String(describing: body))")

		return AF.request(
			url, method: .post, parameters: body,
			encoder: encoder
		).response { [self] response in
			debugPrint(response)

			let statusCode: Int = response.response?.statusCode ?? 999

			print(
				"HttpClient POST \(url) [<--]: \(String(describing: defineStatusCode(code: statusCode))):\(statusCode)"
			)
		}

	}
}

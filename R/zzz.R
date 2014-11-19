# require 'treetop'
# require 'json'
# require 'open-uri'
# require_relative 'biodiversity/version'
# require_relative 'biodiversity/parser'
# require_relative 'biodiversity/guid'

#' LSID revolver
#'
#' @param lsid (character) An LSID
#' @param parse (logical) Parse to \code{XMLInternalDocument} (default) or just get text string
#' @param ... Curl options passed on to \code{\link[httr]{GET}}
#' @return \code{XMLInternalDocument} or character string
#' @examples \donttest{
#' resolve(lsid = 'urn:lsid:ubio.org:namebank:11815')
#' resolve("urn:lsid:ubio.org:classificationbank:2232671")
#' }
resolve <- function(lsid, parsed=TRUE, ...) http_get_rdf(lsid, parsed, ...)

http_get_rdf <- function(lsid, parsed=TRUE, ...){
  res <- GET(paste0(lsid_resolver_url, lsid), ...)
  stop_for_status(res)
  if(parsed) content(res) else content(res, "text")
}

lsid_resolver_url <- 'http://lsid.tdwg.org/'

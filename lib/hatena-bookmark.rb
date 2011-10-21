require 'rubygems'
require 'oauth'
require 'crack'

module Hatena
  class Bookmark

    def initialize(params)
      consumer = OAuth::Consumer.new(
        params[:consumer_key],
        params[:consumer_secret]
      )

      @access_token = OAuth::AccessToken.new(
        consumer,
        params[:request_token],
        params[:request_secret]
      )
    end

    def get(path,options={})
      @response = @access_token.get("http://b.hatena.ne.jp/atom#{path}#{query_params(options)}")
      Crack::XML.parse(@response.body)
    end

    def query_params(params={})
      query = ""
      params.each do |key,value|
        query.empty? ? query = "?#{key}=#{value}" : query = "#{query}&#{key}=#{value}"
      end
      query
    end

    def post(path,xml)
      @response = @access_token.post("http://b.hatena.ne.jp/atom#{path}", xml, {'Content-Type' => 'application/x.atom+xml'})
      Crack::XML.parse(@response.body)
    end

    def put(path,xml)
      @response = @access_token.put("http://b.hatena.ne.jp/atom#{path}", xml, {'Content-Type' => 'application/x.atom+xml'})
      Crack::XML.parse(@response.body)
    end

    def delete(path,options={})
      @response = @access_token.delete("http://b.hatena.ne.jp/atom#{path}#{query_params(options)}")
    end

    def ok? 
      @response.is_a? Net::HTTPOK
    end

    def ping
      get('')
    end

    def create(params)

xml =<<XML
<entry xmlns="http://purl.org/atom/ns#">
  <title>#{params[:title]}</title>
  <link rel="related" type="text/html" href="#{params[:url]}" />
  <summary type="text/plain">#{params[:comment]}</summary>
</entry>
XML

      post('/post', xml)
    end

    def get_edit(options)
      get("/edit/#{options[:eid]}",options)
    end

    def put_edit(params)

xml =<<XML
<entry xmlns="http://purl.org/atom/ns#">
  <title>#{params[:title]}</title>
  <summary type="text/plain">#{params[:comment]}</summary>
</entry>
XML
      put("/edit/#{params[:eid]}",xml)
    end

    def delete_edit(params,options={})
      delete("/edit/#{params[:eid]}",options)
    end

    def feed
      get('/feed')
    end

  end
end

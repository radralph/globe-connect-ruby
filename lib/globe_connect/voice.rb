class Voice
  def initialize(params = {}, &block)
    # say can be stacked and we need to save the things here
    @say = Array.new

    # initialize things
    @response = { :tropo => Array.new }

    @building = true
  end

  def ask(params = {}, instance = false, &block)
    hash    = nil
    params  = set_recognizer(params)

    if params.kind_of? Array
      # multiple instance of ask so just return it
      return params
    else
      # build hash
      hash = build_action('ask', params)
    end

    if instance || params.key?(:instance)
      return hash[:ask]
    end

    @response[:tropo] << hash
  end

  def call(params={}, &block)
    if block_given?
      create_nested_hash('call', params)
      instance_exec(&block)
      @response[:tropo] << @nested_hash
    else
      hash = build_action('call', params)
      @response[:tropo] << hash
    end

    if @building.nil?
      return render
    end
  end

  def choices(params={}, instance = false)
    hash = build_action('choices', params)

    if @nested_hash
      @nested_hash[@nested_name.to_sym].merge!(hash)
    else
      # check if this is an instance, if it is we return the builded hash
      if instance
        return hash[:choices]
      end

      @response[:tropo] << hash

      if @building.nil?
        return render
      end
    end
  end

  def connect(params={}, instance = false)
    hash = build_action('connect', params)

    if @nested_hash
      @nested_hash[@nested_name.to_sym].merge!(hash)
    else
      # check if this is an instance, if it is we return the builded hash
      if instance
        return hash[:connect]
      end

      @response[:tropo] << hash

      if @building.nil?
        return render
      end
    end
  end

  def conference(params={}, &block)
    if block_given?
      create_nested_hash('conference', params)
      instance_exec(&block)
      @response[:tropo] << @nested_hash
    else
      hash = build_action('conference', params)
      @response[:tropo] << hash
    end

    if @building.nil?
      return render
    end
  end

  def hangup
    @response[:tropo] << { :hangup => nil }
    if @building.nil?
      return render
    end
  end

  def headers(params = {}, instance = false, &block)
    response = Array.new

    if block_given?
      create_nested_hash('headers', params)
      instance_exec(&block)
      response = @nested_hash
    else
      hash = build_action('headers', params)
      response = hash
    end

    # are we using the headers just to generate the header?
    if instance
      # return the headers
      return response[:headers]
    end

    @response[:tropo] << response
  end

  def join_prompt(params = {}, instance = false, &block)
    hash = build_action('join_prompt', params)

    if @nested_hash
      @nested_hash[@nested_name.to_sym].merge!(hash)
    else
      # check if this is an instance, if it is we return the builded hash
      if instance
        return hash[:join_prompt]
      end

      @response[:tropo] << hash

      if @building.nil?
        return render
      end
    end
  end

  def leave_prompt(params = {}, instance = false, &block)
    hash = build_action('leave_prompt', params)

    if @nested_hash
      @nested_hash[@nested_name.to_sym].merge!(hash)
    else
      # check if this is an instance, if it is we return the builded hash
      if instance
        return hash[:leave_prompt]
      end

      @response[:tropo] << hash

      if @building.nil?
        return render
      end
    end
  end

  def machine_detection(params = {}, &block)
    if block_given?
      create_nested_hash('machine_detection', params)
      instance_exec(&block)
      @response[:tropo] << @nested_hash
    else
      hash = build_action('machine_detection', params)
      @response[:tropo] << hash
    end

    if @building.nil?
      return render
    end
  end

  def message(params={}, &block)
    if block_given?
      create_nested_hash('message', params)
      instance_exec(&block)
      @response[:tropo] << @nested_hash
    else
      hash = build_action('message', params)
      @response[:tropo] << hash
    end

    if @building.nil?
      return render
    end
  end

  def on(params={}, instance = false, &block)
    if params.kind_of? Array
      # multiple instance, just return it
      return params
    end

    # build it
    hash = build_action('on', params)

    if instance
      return hash
    end

    # push to the main array
    @response[:tropo] << { :on => hash }
  end

  def record(params={}, &block)
    if block_given?
      create_nested_hash('record', params)
      instance_exec(&block)
      @response[:tropo] << @nested_hash
    else
      hash = build_action('record', params)
      @response[:tropo] << hash
    end

    if @building.nil?
      return render
    end
  end

  def render
    # check for stacked says
    if @say.any?
      # check how many we have
      if @say.count > 1
        @response[:tropo] << { :say => @say }
      else
        @response[:tropo] << { :say => @say[0] }
      end
    end

    return JSON.pretty_generate(@response)
  end

  def redirect(params={})
    hash = build_action('redirect', params)
    @response[:tropo] << hash

    if @building.nil?
      return render
    end
  end

  def reject
    @response[:tropo] << { :reject => nil }

    if @building.nil?
      return render
    end
  end

  def say(value = nil, params = {}, instance = false)
    if value.kind_of? String
      params[:value] = value
    elsif value.kind_of? Hash
      params = value
    elsif value.kind_of? Array
      params = value
    else
      # we'll stop here, there's nothing to do.
      return
    end

    if params.kind_of? Array
      hash = Array.new
      params.each do |param|
        param = set_recognizer(param)
        hash.push(build_action('say', param)[:say])
      end
    elsif params.kind_of? Hash
      param = set_recognizer(params)
      hash = build_action('say', param)
    else
      params = set_recognizer(params)
      hash = build_action('say', params)
    end

    # check if this is an instance, if it is we return the builded hash
    if instance
      return hash[:say]
    end

    # save everything in the say attribute
    # check first if the hash is an array
    if hash.kind_of? Array
      @say = hash
    else
      @say << hash[:say]
    end

    # if @nested_hash && @nested_on_hash.nil?
    #   @nested_hash[@nested_name.to_sym].merge!(response)
    # elsif @nested_on_hash
    #   @nested_on_hash[:on][@nested_on_hash_cnt].merge!(response)
    #   @nested_on_hash_cnt += 1
    # else
    if @building.nil?
      return render
    end
    # end
  end

  def start_recording(params={})
    if block_given?
      create_nested_hash('start_recording', params)
      instance_exec(&block)
      @response[:tropo] << @nested_hash
    else
      hash = build_action('start_recording', params)
      @response[:tropo] << hash
    end

    if @building.nil?
      return render
    end
  end

  def stop_recording
    @response[:tropo] << { :stopRecording => nil }
    render_response if @building.nil?
  end

  def transcription(params = {}, instance = false, &block)
    hash = build_action('transcription', params)

    if @nested_hash
      @nested_hash[@nested_name.to_sym].merge!(hash)
    else
      # check if this is an instance, if it is we return the builded hash
      if instance
        return hash[:transcription]
      end

      @response[:tropo] << hash

      if @building.nil?
        return render
      end
    end
  end

  def transfer(params={}, &block)
    if block_given?
      create_nested_hash('transfer', params)
      instance_exec(&block)
      @response[:tropo] << @nested_hash
    else
      hash = build_action('transfer', params)
      @response[:tropo] << hash
    end

    if @building.nil?
      return render
    end
  end

  def wait(params={}, &block)
    if block_given?
      create_nested_hash('wait', params)
      instance_exec(&block)
      @response[:tropo] << @nested_hash
    else
      hash = build_action('wait', params)
      @response[:tropo] << hash
    end

    if @building.nil?
      return render
    end
  end

  # Here goes our private functions
  private
  def build_action(action, params)
    if action == 'on'
      return build_elements(params)
    else
      return { action.to_sym => build_elements(params) }
    end
  end

  def build_elements(params)
    hash = Hash.new

    params.each_pair do |k,v|
      if k.to_s.include? "_"
        k = camelize(k.to_s)
        k = k.to_sym if k
      end
      hash.merge!({ k => v })
    end

    return hash
  end

  def camelize(string)
    split_string = string.split('_')
    return_string = split_string[0] + split_string[1].capitalize
    return_string = return_string + split_string[2].capitalize if split_string[2]

    return return_string
  end

  def create_nested_hash(name, params)
    @nested_hash = build_action(name, params)
    @nested_name = name
  end

  def create_on_hash
    @on_hash ||= { :on => Array.new }
  end

  def set_recognizer(params)
    params.merge!({ :recognizer => @recognizer }) if params[:recognizer].nil? && @recognizer
    return params
  end
end

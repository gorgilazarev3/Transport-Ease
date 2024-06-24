<div class="grid grid-cols-2 gap-5">
    <div class="bg-white max-w-2xl shadow overflow-hidden sm:rounded-lg mx-auto mt-4">
        <div class="px-4 py-5 sm:px-6">
            <h3 class="text-lg leading-6 font-medium text-gray-900">
                Provider Details
            </h3>
            <p class="mt-1 max-w-2xl text-sm text-gray-500">
                Details and informations about the provider.
            </p>
        </div>
        <div class="border-t border-gray-200">
            <dl>
                <div class="bg-gray-50 px-4 py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                    <dt class="text-sm font-medium text-gray-500">
                        Full name
                    </dt>
                    <dd class="mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2">
                        {{ $provider->name }}
                    </dd>
                </div>
                <div class="bg-white px-4 py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                    <dt class="text-sm font-medium text-gray-500">
                        Type of provider
                    </dt>
                    <dd class="mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2">
                        {{ strtoupper($provider->role) }}
                    </dd>
                </div>
                <div class="ms-16 bg-white px-4 py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                    @if(strtolower($provider->role) == 'regular_driver' || strtolower($provider->role) == 'taxi_driver')
                        <dt class="text-sm font-medium text-gray-500">
                            License plate
                        </dt>
                        <dd class="mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2">
                            {{ $provider->license_plate }}
                        </dd>
                    @endif
                    @if(strtolower($provider->role) == 'regular_driver')
                        <dt class="text-sm font-medium text-gray-500">
                            Car model
                        </dt>
                        <dd class="mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2">
                            {{ $provider->car_color }} {{ $provider->car_model }}
                        </dd>
                    @endif
                    @if(strtolower($provider->role) == 'taxi_driver')
                        <dt class="text-sm font-medium text-gray-500">
                            Taxi Company
                        </dt>
                        <dd class="mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2">
                            {{ $provider->taxi_company_name }}
                        </dd>
                        <dt class="text-sm font-medium text-gray-500">
                            Available seats
                        </dt>
                        <dd class="mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2">
                            {{ $provider->taxi_car_seats }}
                        </dd>
                    @endif
                    @if(strtolower($provider->role) == 'transporting_driver')
                        <dt class="text-sm font-medium text-gray-500">
                            Type of transport
                        </dt>
                        <dd class="mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2">
                            {{ strtoupper($provider->provider_type) }}
                        </dd>
                        @if(strtolower($provider->provider_type) == 'carrier_provider')
                            <dt class="text-sm font-medium text-gray-500">
                                Carrier Capacity
                            </dt>
                            <dd class="mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2">
                                {{ $provider->carrier_capacity }}
                            </dd>
                        @elseif(strtolower($provider->provider_type) == 'passengers_provider')
                            <dt class="text-sm font-medium text-gray-500">
                                Routes Type
                            </dt>
                            <dd class="mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2">
                                {{ $provider->routes_type }}
                            </dd>
                            <dt class="text-sm font-medium text-gray-500">
                                Available seats
                            </dt>
                            <dd class="mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2">
                                {{ $provider->provider_seats }}
                            </dd>
                        @endif
                    @endif

                </div>
                <div class="bg-gray-50 px-4 py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                    <dt class="text-sm font-medium text-gray-500">
                        Email address
                    </dt>
                    <dd class="mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2">
                        {{ $provider->email }}
                    </dd>
                </div>
                <div class="bg-white px-4 py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                    <dt class="text-sm font-medium text-gray-500">
                        Earnings (as of {{ date('d/m/Y H:i:s') }})
                    </dt>
                    <dd class="mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2">
                        {{ $provider->earnings }} MKD
                    </dd>
                </div>
                <div class="bg-gray-50 px-4 py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                    <dt class="text-sm font-medium text-gray-500">
                        Rating
                    </dt>
                    <dd class="mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2">
                        {{ $provider->ratings }}
                        <div style="display: inline;">


                            @for($i=0; $i < intval($provider->ratings); $i++)
                                <svg style="display: inline" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" class="size-6">
                                    <path fill-rule="evenodd" d="M10.788 3.21c.448-1.077 1.976-1.077 2.424 0l2.082 5.006 5.404.434c1.164.093 1.636 1.545.749 2.305l-4.117 3.527 1.257 5.273c.271 1.136-.964 2.033-1.96 1.425L12 18.354 7.373 21.18c-.996.608-2.231-.29-1.96-1.425l1.257-5.273-4.117-3.527c-.887-.76-.415-2.212.749-2.305l5.404-.434 2.082-5.005Z" clip-rule="evenodd" />
                                </svg>
                            @endfor

                            @for($i=0; $i < 5 - intval($provider->ratings); $i++)
                                <svg style="display: inline" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                                    <path stroke-linecap="round" stroke-linejoin="round" d="M11.48 3.499a.562.562 0 0 1 1.04 0l2.125 5.111a.563.563 0 0 0 .475.345l5.518.442c.499.04.701.663.321.988l-4.204 3.602a.563.563 0 0 0-.182.557l1.285 5.385a.562.562 0 0 1-.84.61l-4.725-2.885a.562.562 0 0 0-.586 0L6.982 20.54a.562.562 0 0 1-.84-.61l1.285-5.386a.562.562 0 0 0-.182-.557l-4.204-3.602a.562.562 0 0 1 .321-.988l5.518-.442a.563.563 0 0 0 .475-.345L11.48 3.5Z" />
                                </svg>

                            @endfor
                        </div>
                    </dd>
                </div>
            </dl>
        </div>
    </div>

    <div class="bg-white max-w-2xl shadow overflow-hidden sm:rounded-lg mx-auto mt-4">
        <div class="px-4 py-5 sm:px-6">
            <h3 class="text-lg leading-6 font-medium text-gray-900">
                Ride Details
            </h3>
            <p class="mt-1 max-w-2xl text-sm text-gray-500">
                Details about the rides of the provider.
            </p>
        </div>
        <div class="border-t border-gray-200">
            <dl>
                <div class="bg-gray-50 px-4 py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                    <div class="mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-3 border-b-4 border-b-teal-950">
                        @if(strtolower($provider->role) == 'taxi_driver')
                            <img class="mx-auto" src="{{ url('/images/taxi_render.png') }}" width="200" alt="Picture of a taxi car">
                        @elseif(strtolower($provider->role) == 'regular_driver')
                                <img class="mx-auto" src="{{ url('/images/regular_car_render.png') }}" width="200" alt="Picture of a white car">
                        @endif
                    </div>
                </div>
                <div class="bg-white px-4 py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                    <dt class="text-sm font-medium text-gray-500">
                        Number of rides completed
                    </dt>
                    <dd class="mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2">
                        {{ count($rideRequests) }}
                    </dd>
                </div>
                <div class="bg-white px-4 py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                    <p class="text-md font-semibold text-gray-500 mx-auto sm:col-span-3">
                        Trip History
                    </p>
                </div>
                <div class="bg-gray-50 px-4 py-5 sm:grid sm:gap-4 sm:px-6">
                    @foreach($rideRequests as $rr)

                            <div class="row-auto text-sm font-medium text-gray-500">
                                <div class="col-auto">
                                    <span class="grid grid-cols-6 border-b-2 border-gray-200 text-sm">
                                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                                        <path stroke-linecap="round" stroke-linejoin="round" d="M15 10.5a3 3 0 1 1-6 0 3 3 0 0 1 6 0Z" />
                                        <path stroke-linecap="round" stroke-linejoin="round" d="M19.5 10.5c0 7.142-7.5 11.25-7.5 11.25S4.5 17.642 4.5 10.5a7.5 7.5 0 1 1 15 0Z" />
                                    </svg>
                                    <span class="col-span-3">{{ $rr->pickup_address }}</span>
                                        <span class="col-span-2">{{ $rr->updated_at }}</span>
                                    </span>

                                </div>
                                <div class="col-auto">
                                    <span class="grid grid-cols-6 border-b-2 border-teal-700">
                                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
  <path stroke-linecap="round" stroke-linejoin="round" d="M9 6.75V15m6-6v8.25m.503 3.498 4.875-2.437c.381-.19.622-.58.622-1.006V4.82c0-.836-.88-1.38-1.628-1.006l-3.869 1.934c-.317.159-.69.159-1.006 0L9.503 3.252a1.125 1.125 0 0 0-1.006 0L3.622 5.689C3.24 5.88 3 6.27 3 6.695V19.18c0 .836.88 1.38 1.628 1.006l3.869-1.934c.317-.159.69-.159 1.006 0l4.994 2.497c.317.158.69.158 1.006 0Z" />
</svg>
                                        <span class="col-span-3">{{ $rr->destination_address }} </span>

<span class="col-span-2">{{ $rr->fare }} MKD</span>
                                    </span>
                                </div>
                            </div>


                    @endforeach

                    {{ $rideRequests->links() }}
                </div>
            </dl>
        </div>
    </div>
</div>



</div>

<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight text-center">
            Admin Panel
        </h2>
    </x-slot>

    <x-slot name="slot">

        <div class="grid grid-cols-3 gap-0">

            <!-- Sidebar Component Start -->
            <div class="flex flex-col items-center w-40 h-full overflow-hidden text-teal-300 bg-teal-800 rounded">
                <a class="flex items-center w-full px-3 mt-3" href="#">
                    <svg class="w-8 h-8 fill-current" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"
                         fill="currentColor">
                        <path
                            d="M11 17a1 1 0 001.447.894l4-2A1 1 0 0017 15V9.236a1 1 0 00-1.447-.894l-4 2a1 1 0 00-.553.894V17zM15.211 6.276a1 1 0 000-1.788l-4.764-2.382a1 1 0 00-.894 0L4.789 4.488a1 1 0 000 1.788l4.764 2.382a1 1 0 00.894 0l4.764-2.382zM4.447 8.342A1 1 0 003 9.236V15a1 1 0 00.553.894l4 2A1 1 0 009 17v-5.764a1 1 0 00-.553-.894l-4-2z"/>
                    </svg>
                    <span class="ml-2 text-sm font-bold text-center">TransportEase Admin </span>
                </a>
                <div class="w-full px-2">
                    <div class="flex flex-col items-center w-full mt-3 border-t border-indigo-400  ">
                        <a class="{{ Request::get('activeLink') == null ? 'active' : '' }}  [&.active]:bg-teal-600  flex items-center w-full h-12 px-3 mt-2 rounded hover:bg-teal-600"
                           href="/admin">
                            <svg class="w-6 h-6 stroke-current" xmlns="http://www.w3.org/2000/svg" fill="none"
                                 viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                      d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"/>
                            </svg>
                            <span class="ml-2 text-sm font-medium">Dashboard</span>
                        </a>
                        <a class="{{ Request::get('activeLink') == 'users' ? 'active' : '' }} [&.active]:bg-teal-600 flex items-center w-full h-12 px-3 mt-2 rounded hover:bg-teal-600"
                           href="/admin?activeLink=users&panelAction=allUsers">
                            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5"
                                 stroke="currentColor" class="size-6">
                                <path stroke-linecap="round" stroke-linejoin="round"
                                      d="M15 19.128a9.38 9.38 0 0 0 2.625.372 9.337 9.337 0 0 0 4.121-.952 4.125 4.125 0 0 0-7.533-2.493M15 19.128v-.003c0-1.113-.285-2.16-.786-3.07M15 19.128v.106A12.318 12.318 0 0 1 8.624 21c-2.331 0-4.512-.645-6.374-1.766l-.001-.109a6.375 6.375 0 0 1 11.964-3.07M12 6.375a3.375 3.375 0 1 1-6.75 0 3.375 3.375 0 0 1 6.75 0Zm8.25 2.25a2.625 2.625 0 1 1-5.25 0 2.625 2.625 0 0 1 5.25 0Z"/>
                            </svg>

                            <span class="ml-2 text-sm font-medium">Users</span>
                        </a>
                        <a class="{{ Request::get('activeLink') == 'providers' ? 'active' : '' }} flex [&.active]:bg-teal-600 items-center w-full h-12 px-3 mt-2  [&.active]:text-teal-100 hover:bg-teal-600 rounded"
                           href="/admin?activeLink=providers">
                            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5"
                                 stroke="currentColor" class="size-6">
                                <path stroke-linecap="round" stroke-linejoin="round"
                                      d="M8.25 18.75a1.5 1.5 0 0 1-3 0m3 0a1.5 1.5 0 0 0-3 0m3 0h6m-9 0H3.375a1.125 1.125 0 0 1-1.125-1.125V14.25m17.25 4.5a1.5 1.5 0 0 1-3 0m3 0a1.5 1.5 0 0 0-3 0m3 0h1.125c.621 0 1.129-.504 1.09-1.124a17.902 17.902 0 0 0-3.213-9.193 2.056 2.056 0 0 0-1.58-.86H14.25M16.5 18.75h-2.25m0-11.177v-.958c0-.568-.422-1.048-.987-1.106a48.554 48.554 0 0 0-10.026 0 1.106 1.106 0 0 0-.987 1.106v7.635m12-6.677v6.677m0 4.5v-4.5m0 0h-12"/>
                            </svg>
                            <span class="ml-2 text-sm font-medium">Providers</span>
                        </a>
                        <a class="{{ Request::get('activeLink') == 'rideRequests' ? 'active' : '' }} flex items-center w-full h-12 px-3 mt-2 rounded hover:bg-teal-600 [&.active]:text-teal-100 [&.active]:bg-teal-600"
                           href="/admin?activeLink=rideRequests&panelAction=allRideRequests">
                            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5"
                                 stroke="currentColor" class="size-6">
                                <path stroke-linecap="round" stroke-linejoin="round"
                                      d="M9 6.75V15m6-6v8.25m.503 3.498 4.875-2.437c.381-.19.622-.58.622-1.006V4.82c0-.836-.88-1.38-1.628-1.006l-3.869 1.934c-.317.159-.69.159-1.006 0L9.503 3.252a1.125 1.125 0 0 0-1.006 0L3.622 5.689C3.24 5.88 3 6.27 3 6.695V19.18c0 .836.88 1.38 1.628 1.006l3.869-1.934c.317-.159.69-.159 1.006 0l4.994 2.497c.317.158.69.158 1.006 0Z"/>
                            </svg>
                            <span class="ml-2 text-sm font-medium">Ride Requests</span>
                        </a>
                    </div>
                </div>
                <a class="mt-60 mb-5 flex items-center justify-center w-full h-16 bg-teal-800 hover:bg-teal-600"
                   href="/user/profile">
                    <svg class="w-6 h-6 stroke-current" xmlns="http://www.w3.org/2000/svg" fill="none"
                         viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                              d="M5.121 17.804A13.937 13.937 0 0112 16c2.5 0 4.847.655 6.879 1.804M15 10a3 3 0 11-6 0 3 3 0 016 0zm6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                    </svg>
                    <span class="ml-2 text-sm font-medium">Account</span>
                </a>
            </div>
            <!-- Component End  -->


            <div class="col-span-2" style="margin-left: -20em;">

                @if(Request::get('activeLink') == null)
                    <div class="grid grid-cols-4 gap-24 mt-5 mb-5">
                        <div class="block max-w-sm p-6 bg-white border border-gray-200 rounded-lg shadow hover:bg-gray-100 dark:bg-gray-800 dark:border-gray-700 dark:hover:bg-gray-700">
                            <div class="grid grid-cols-3">
                                <div class="col-span-2">
                                    <p>Total users</p>
                                    <p class="font-extrabold">{{ count($usersList) }}</p>
                                </div>
                                <div class="col-span-1">
                                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-12 align-middle">
                                        <path stroke-linecap="round" stroke-linejoin="round" d="M15 19.128a9.38 9.38 0 0 0 2.625.372 9.337 9.337 0 0 0 4.121-.952 4.125 4.125 0 0 0-7.533-2.493M15 19.128v-.003c0-1.113-.285-2.16-.786-3.07M15 19.128v.106A12.318 12.318 0 0 1 8.624 21c-2.331 0-4.512-.645-6.374-1.766l-.001-.109a6.375 6.375 0 0 1 11.964-3.07M12 6.375a3.375 3.375 0 1 1-6.75 0 3.375 3.375 0 0 1 6.75 0Zm8.25 2.25a2.625 2.625 0 1 1-5.25 0 2.625 2.625 0 0 1 5.25 0Z" />
                                    </svg>

                                </div>
                            </div>


                        </div>

                        <div class="block max-w-sm p-6 bg-white border border-gray-200 rounded-lg shadow hover:bg-gray-100 dark:bg-gray-800 dark:border-gray-700 dark:hover:bg-gray-700">
                            <div class="grid grid-cols-3">
                                <div class="col-span-2">
                                    <p>Active providers</p>
                                    <p class="font-extrabold">{{ count($providersList) }}</p>
                                </div>
                                <div class="col-span-1">
                                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-12">
                                        <path stroke-linecap="round" stroke-linejoin="round" d="M8.25 18.75a1.5 1.5 0 0 1-3 0m3 0a1.5 1.5 0 0 0-3 0m3 0h6m-9 0H3.375a1.125 1.125 0 0 1-1.125-1.125V14.25m17.25 4.5a1.5 1.5 0 0 1-3 0m3 0a1.5 1.5 0 0 0-3 0m3 0h1.125c.621 0 1.129-.504 1.09-1.124a17.902 17.902 0 0 0-3.213-9.193 2.056 2.056 0 0 0-1.58-.86H14.25M16.5 18.75h-2.25m0-11.177v-.958c0-.568-.422-1.048-.987-1.106a48.554 48.554 0 0 0-10.026 0 1.106 1.106 0 0 0-.987 1.106v7.635m12-6.677v6.677m0 4.5v-4.5m0 0h-12" />
                                    </svg>
                                </div>
                            </div>


                        </div>

                        <div class="block max-w-sm p-6 bg-white border border-gray-200 rounded-lg shadow hover:bg-gray-100 dark:bg-gray-800 dark:border-gray-700 dark:hover:bg-gray-700">
                            <div class="grid grid-cols-3">
                                <div class="col-span-2">
                                    <p>Number of ride requests</p>
                                    <p class="font-extrabold">{{ count($rideRequests) }}</p>
                                </div>
                                <div class="col-span-1">
                                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-12">
                                        <path stroke-linecap="round" stroke-linejoin="round" d="M9 6.75V15m6-6v8.25m.503 3.498 4.875-2.437c.381-.19.622-.58.622-1.006V4.82c0-.836-.88-1.38-1.628-1.006l-3.869 1.934c-.317.159-.69.159-1.006 0L9.503 3.252a1.125 1.125 0 0 0-1.006 0L3.622 5.689C3.24 5.88 3 6.27 3 6.695V19.18c0 .836.88 1.38 1.628 1.006l3.869-1.934c.317-.159.69-.159 1.006 0l4.994 2.497c.317.158.69.158 1.006 0Z" />
                                    </svg>
                                </div>
                            </div>


                        </div>

                        <div class="block max-w-sm p-6 bg-white border border-gray-200 rounded-lg shadow hover:bg-gray-100 dark:bg-gray-800 dark:border-gray-700 dark:hover:bg-gray-700">
                            <div class="grid grid-cols-3">
                                <div class="col-span-2">
                                    <p>Total fares</p>
                                    <p class="font-extrabold">{{ $rideRequests->sum('fare') }} MKD</p>
                                </div>
                                <div class="col-span-1">
                                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-12">
                                        <path stroke-linecap="round" stroke-linejoin="round" d="M9 6.75V15m6-6v8.25m.503 3.498 4.875-2.437c.381-.19.622-.58.622-1.006V4.82c0-.836-.88-1.38-1.628-1.006l-3.869 1.934c-.317.159-.69.159-1.006 0L9.503 3.252a1.125 1.125 0 0 0-1.006 0L3.622 5.689C3.24 5.88 3 6.27 3 6.695V19.18c0 .836.88 1.38 1.628 1.006l3.869-1.934c.317-.159.69-.159 1.006 0l4.994 2.497c.317.158.69.158 1.006 0Z" />
                                    </svg>
                                </div>
                            </div>


                        </div>
                    </div>
                    <div class="grid grid-cols-3 gap-6">
                        <div class="block max-w-lg p-6 bg-white border border-gray-200 rounded-lg shadow hover:bg-gray-100 dark:bg-gray-800 dark:border-gray-700 dark:hover:bg-gray-700">

                            <canvas id="myChart"></canvas>

                        </div>
                        <div class="block max-w-lg p-6 bg-white border border-gray-200 rounded-lg shadow hover:bg-gray-100 dark:bg-gray-800 dark:border-gray-700 dark:hover:bg-gray-700">

                            <canvas id="rideRequestsNumChart"></canvas>

                        </div>

                        <div class="block max-w-lg p-6 bg-white border border-gray-200 rounded-lg shadow hover:bg-gray-100 dark:bg-gray-800 dark:border-gray-700 dark:hover:bg-gray-700">

                            <canvas id="providersTypeDistributionChart"></canvas>

                        </div>
                    </div>
                @endif

                @if(Request::get('activeLink') == 'users' && Request::get('panelAction') == null)
                    <div class="grid grid-cols-3">
                        <div class="flex flex-col justify-center overflow-hidden py-6 sm:py-12">
                            <div
                                class="group relative cursor-pointer overflow-hidden bg-white px-6 pt-10 pb-8 shadow-xl ring-1 ring-gray-900/5 transition-all duration-300 hover:-translate-y-1 hover:shadow-2xl sm:mx-auto sm:max-w-sm sm:rounded-lg sm:px-10">
                                <span
                                    class="absolute top-10 z-0 h-20 w-20 rounded-full bg-sky-500 transition-all duration-300 group-hover:scale-[10]"></span>
                                <div class="relative z-10 mx-auto max-w-md">
            <span
                class="grid h-20 w-20 place-items-center rounded-full bg-sky-500 transition-all duration-300 group-hover:bg-sky-400">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5"
                     stroke="currentColor" class="size-6 text-white">
  <path stroke-linecap="round" stroke-linejoin="round"
        d="M18 18.72a9.094 9.094 0 0 0 3.741-.479 3 3 0 0 0-4.682-2.72m.94 3.198.001.031c0 .225-.012.447-.037.666A11.944 11.944 0 0 1 12 21c-2.17 0-4.207-.576-5.963-1.584A6.062 6.062 0 0 1 6 18.719m12 0a5.971 5.971 0 0 0-.941-3.197m0 0A5.995 5.995 0 0 0 12 12.75a5.995 5.995 0 0 0-5.058 2.772m0 0a3 3 0 0 0-4.681 2.72 8.986 8.986 0 0 0 3.74.477m.94-3.197a5.971 5.971 0 0 0-.94 3.197M15 6.75a3 3 0 1 1-6 0 3 3 0 0 1 6 0Zm6 3a2.25 2.25 0 1 1-4.5 0 2.25 2.25 0 0 1 4.5 0Zm-13.5 0a2.25 2.25 0 1 1-4.5 0 2.25 2.25 0 0 1 4.5 0Z"/>
</svg>

            </span>
                                    <div
                                        class="space-y-6 pt-5 text-base leading-7 text-gray-600 transition-all duration-300 group-hover:text-white/90">
                                        <p>View all users in database</p>
                                    </div>
                                    <div class="pt-5 text-base font-semibold leading-7">
                                        <p>
                                            <a href="/admin?activeLink=users&panelAction=allUsers"
                                               class="text-sky-500 transition-all duration-300 group-hover:text-white">Open
                                                user table
                                                &rarr;
                                            </a>
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>

                @endif



                @if(Request::get('activeLink') == 'users' && Request::get('panelAction') == 'allUsers')

                    <div class="mt-16 relative overflow-x-auto shadow-md sm:rounded-lg mx-auto">
                        <table class="border w-full text-sm text-left rtl:text-right text-gray-500 dark:text-gray-400">
                            <caption
                                class="p-5 text-lg font-semibold text-left rtl:text-right text-gray-900 bg-white dark:text-white dark:bg-gray-800">
                                Users
                                <p class="mt-1 text-sm font-normal text-gray-500 dark:text-gray-400">A list of all the
                                    users in your account including their name, phone number, email and role.</p>
                            </caption>
                            <thead
                                class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
                            <tr>
                                <th scope="col" class="px-6 py-3">
                                    Name
                                </th>
                                <th scope="col" class="px-6 py-3">
                                    Phone number
                                </th>
                                <th scope="col" class="px-6 py-3">
                                    Email
                                </th>
                                <th scope="col" class="px-6 py-3">
                                    Role
                                </th>
                                <th scope="col" class="px-6 py-3">
                                    <span class="sr-only">Edit</span>
                                </th>
                            </tr>
                            </thead>
                            <tbody class="odd:bg-indigo-400 even:bg-white">
                            @foreach($userList as $user)
                                <tr class="odd:bg-indigo-50 even:bg-white hover:bg-indigo-100 bg-white border-b dark:bg-gray-800 dark:border-gray-700">
                                    <th scope="row"
                                        class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                        {{ $user->name }}
                                    </th>
                                    <td class="px-6 py-4">
                                        {{ $user->phone_number }}
                                    </td>
                                    <td class="px-6 py-4">
                                        {{ $user->email }}
                                    </td>
                                    <td class="px-6 py-4">
                                        {{ strtoupper($user->role) }}
                                    </td>
                                    <td class="px-6 py-4 text-right">
                                        <a href="#"
                                           class="font-medium text-blue-600 dark:text-blue-500 hover:underline">Edit</a>
                                    </td>
                                </tr>
                            @endforeach


                            </tbody>
                        </table>
                    </div>

                    <div class="mt-3">
                        {{ $userList->links() }}

                    </div>
                @endif


                {{--        PROVIDERS--}}
                @if(Request::get('activeLink') == 'providers' && Request::get('panelAction') == null)
                    <div class="grid grid-cols-3">
                        <div class="flex flex-col justify-center overflow-hidden py-6 sm:py-12">
                            <div
                                class="group relative cursor-pointer overflow-hidden bg-white px-6 pt-10 pb-8 shadow-xl ring-1 ring-gray-900/5 transition-all duration-300 hover:-translate-y-1 hover:shadow-2xl sm:mx-auto sm:max-w-sm sm:rounded-lg sm:px-10">
                                <span
                                    class="absolute top-10 z-0 h-20 w-20 rounded-full bg-teal-500 transition-all duration-300 group-hover:scale-[10]"></span>
                                <div class="relative z-10 mx-auto max-w-md">
            <span
                class="grid h-20 w-20 place-items-center rounded-full bg-teal-500 transition-all duration-300 group-hover:bg-teal-400">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5"
                     stroke="currentColor" class="size-6">
  <path stroke-linecap="round" stroke-linejoin="round"
        d="M18 18.72a9.094 9.094 0 0 0 3.741-.479 3 3 0 0 0-4.682-2.72m.94 3.198.001.031c0 .225-.012.447-.037.666A11.944 11.944 0 0 1 12 21c-2.17 0-4.207-.576-5.963-1.584A6.062 6.062 0 0 1 6 18.719m12 0a5.971 5.971 0 0 0-.941-3.197m0 0A5.995 5.995 0 0 0 12 12.75a5.995 5.995 0 0 0-5.058 2.772m0 0a3 3 0 0 0-4.681 2.72 8.986 8.986 0 0 0 3.74.477m.94-3.197a5.971 5.971 0 0 0-.94 3.197M15 6.75a3 3 0 1 1-6 0 3 3 0 0 1 6 0Zm6 3a2.25 2.25 0 1 1-4.5 0 2.25 2.25 0 0 1 4.5 0Zm-13.5 0a2.25 2.25 0 1 1-4.5 0 2.25 2.25 0 0 1 4.5 0Z"/>
</svg>

            </span>
                                    <div
                                        class="space-y-6 pt-5 text-base leading-7 text-gray-600 transition-all duration-300 group-hover:text-white/90">
                                        <p>View all providers in database</p>
                                    </div>
                                    <div class="pt-5 text-base font-semibold leading-7">
                                        <p>
                                            <a href="/admin?activeLink=providers&panelAction=allProviders"
                                               class="text-teal-500 transition-all duration-300 group-hover:text-white">Open
                                                providers table
                                                &rarr;
                                            </a>
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="flex flex-col justify-center overflow-hidden py-6 sm:py-12">
                            <div
                                class="group relative cursor-pointer overflow-hidden bg-white px-6 pt-10 pb-8 shadow-xl ring-1 ring-gray-900/5 transition-all duration-300 hover:-translate-y-1 hover:shadow-2xl sm:mx-auto sm:max-w-sm sm:rounded-lg sm:px-10">
                                <span
                                    class="absolute top-10 z-0 h-20 w-20 rounded-full bg-teal-500 transition-all duration-300 group-hover:scale-[10]"></span>
                                <div class="relative z-10 mx-auto max-w-md">
            <span
                class="grid h-20 w-20 place-items-center rounded-full bg-teal-500 transition-all duration-300 group-hover:bg-teal-400">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5"
                     stroke="currentColor" class="size-6">
  <path stroke-linecap="round" stroke-linejoin="round"
        d="M18 18.72a9.094 9.094 0 0 0 3.741-.479 3 3 0 0 0-4.682-2.72m.94 3.198.001.031c0 .225-.012.447-.037.666A11.944 11.944 0 0 1 12 21c-2.17 0-4.207-.576-5.963-1.584A6.062 6.062 0 0 1 6 18.719m12 0a5.971 5.971 0 0 0-.941-3.197m0 0A5.995 5.995 0 0 0 12 12.75a5.995 5.995 0 0 0-5.058 2.772m0 0a3 3 0 0 0-4.681 2.72 8.986 8.986 0 0 0 3.74.477m.94-3.197a5.971 5.971 0 0 0-.94 3.197M15 6.75a3 3 0 1 1-6 0 3 3 0 0 1 6 0Zm6 3a2.25 2.25 0 1 1-4.5 0 2.25 2.25 0 0 1 4.5 0Zm-13.5 0a2.25 2.25 0 1 1-4.5 0 2.25 2.25 0 0 1 4.5 0Z"/>
</svg>

            </span>
                                    <div
                                        class="space-y-6 pt-5 text-base leading-7 text-gray-600 transition-all duration-300 group-hover:text-white/90">
                                        <p>View regular drivers in database</p>
                                    </div>
                                    <div class="pt-5 text-base font-semibold leading-7">
                                        <p>
                                            <a href="/admin?activeLink=providers&panelAction=providersByType&providerType=regular_driver"
                                               class="text-teal-500 transition-all duration-300 group-hover:text-white">Open
                                                regular drivers table
                                                &rarr;
                                            </a>
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="flex flex-col justify-center overflow-hidden py-6 sm:py-12">
                            <div
                                class="group relative cursor-pointer overflow-hidden bg-white px-6 pt-10 pb-8 shadow-xl ring-1 ring-gray-900/5 transition-all duration-300 hover:-translate-y-1 hover:shadow-2xl sm:mx-auto sm:max-w-sm sm:rounded-lg sm:px-10">
                                <span
                                    class="absolute top-10 z-0 h-20 w-20 rounded-full bg-teal-500 transition-all duration-300 group-hover:scale-[10]"></span>
                                <div class="relative z-10 mx-auto max-w-md">
            <span
                class="grid h-20 w-20 place-items-center rounded-full bg-teal-500 transition-all duration-300 group-hover:bg-teal-400">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5"
                     stroke="currentColor" class="size-6">
  <path stroke-linecap="round" stroke-linejoin="round"
        d="M18 18.72a9.094 9.094 0 0 0 3.741-.479 3 3 0 0 0-4.682-2.72m.94 3.198.001.031c0 .225-.012.447-.037.666A11.944 11.944 0 0 1 12 21c-2.17 0-4.207-.576-5.963-1.584A6.062 6.062 0 0 1 6 18.719m12 0a5.971 5.971 0 0 0-.941-3.197m0 0A5.995 5.995 0 0 0 12 12.75a5.995 5.995 0 0 0-5.058 2.772m0 0a3 3 0 0 0-4.681 2.72 8.986 8.986 0 0 0 3.74.477m.94-3.197a5.971 5.971 0 0 0-.94 3.197M15 6.75a3 3 0 1 1-6 0 3 3 0 0 1 6 0Zm6 3a2.25 2.25 0 1 1-4.5 0 2.25 2.25 0 0 1 4.5 0Zm-13.5 0a2.25 2.25 0 1 1-4.5 0 2.25 2.25 0 0 1 4.5 0Z"/>
</svg>

            </span>
                                    <div
                                        class="space-y-6 pt-5 text-base leading-7 text-gray-600 transition-all duration-300 group-hover:text-white/90">
                                        <p>View taxi drivers in database</p>
                                    </div>
                                    <div class="pt-5 text-base font-semibold leading-7">
                                        <p>
                                            <a href="/admin?activeLink=providers&panelAction=providersByType&providerType=taxi_driver"
                                               class="text-teal-500 transition-all duration-300 group-hover:text-white">Open
                                                taxi drivers table
                                                &rarr;
                                            </a>
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="flex flex-col justify-center overflow-hidden py-6 sm:py-12">
                            <div
                                class="group relative cursor-pointer overflow-hidden bg-white px-6 pt-10 pb-8 shadow-xl ring-1 ring-gray-900/5 transition-all duration-300 hover:-translate-y-1 hover:shadow-2xl sm:mx-auto sm:max-w-sm sm:rounded-lg sm:px-10">
                                <span
                                    class="absolute top-10 z-0 h-20 w-20 rounded-full bg-teal-500 transition-all duration-300 group-hover:scale-[10]"></span>
                                <div class="relative z-10 mx-auto max-w-md">
            <span
                class="grid h-20 w-20 place-items-center rounded-full bg-teal-500 transition-all duration-300 group-hover:bg-teal-400">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5"
                     stroke="currentColor" class="size-6">
  <path stroke-linecap="round" stroke-linejoin="round"
        d="M18 18.72a9.094 9.094 0 0 0 3.741-.479 3 3 0 0 0-4.682-2.72m.94 3.198.001.031c0 .225-.012.447-.037.666A11.944 11.944 0 0 1 12 21c-2.17 0-4.207-.576-5.963-1.584A6.062 6.062 0 0 1 6 18.719m12 0a5.971 5.971 0 0 0-.941-3.197m0 0A5.995 5.995 0 0 0 12 12.75a5.995 5.995 0 0 0-5.058 2.772m0 0a3 3 0 0 0-4.681 2.72 8.986 8.986 0 0 0 3.74.477m.94-3.197a5.971 5.971 0 0 0-.94 3.197M15 6.75a3 3 0 1 1-6 0 3 3 0 0 1 6 0Zm6 3a2.25 2.25 0 1 1-4.5 0 2.25 2.25 0 0 1 4.5 0Zm-13.5 0a2.25 2.25 0 1 1-4.5 0 2.25 2.25 0 0 1 4.5 0Z"/>
</svg>

            </span>
                                    <div
                                        class="space-y-6 pt-5 text-base leading-7 text-gray-600 transition-all duration-300 group-hover:text-white/90">
                                        <p>View transporting providers in database</p>
                                    </div>
                                    <div class="pt-5 text-base font-semibold leading-7">
                                        <p>
                                            <a href="/admin?activeLink=providers&panelAction=providersByType&providerType=transporting_driver"
                                               class="text-teal-500 transition-all duration-300 group-hover:text-white">Open
                                                transporting providers table
                                                &rarr;
                                            </a>
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>

                @endif

                @if(Request::get('activeLink') == 'providers' && Request::get('panelAction') == 'allProviders')

                    <div class="mt-16 relative overflow-x-auto shadow-md sm:rounded-lg">
                        <table class="border w-full text-sm text-left rtl:text-right text-gray-500 dark:text-gray-400">
                            <caption
                                class="p-5 text-lg font-semibold text-left rtl:text-right text-gray-900 bg-white dark:text-white dark:bg-gray-800">
                                Providers
                                <p class="mt-1 text-sm font-normal text-gray-500 dark:text-gray-400">A list of all the
                                    providers in the database including information.</p>
                            </caption>
                            <thead
                                class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
                            <tr>
                                <th scope="col" class="px-6 py-3">
                                    Name
                                </th>
                                <th scope="col" class="px-6 py-3">
                                    Phone number
                                </th>
                                <th scope="col" class="px-6 py-3">
                                    Email
                                </th>
                                <th scope="col" class="px-6 py-3">
                                    Type of provider
                                </th>
                                <th scope="col" class="px-6 py-3">
                                    Earnings
                                </th>
                                <th scope="col" class="px-6 py-3">
                                    Rating
                                </th>
                                <th scope="col" class="px-6 py-3">
                                    <span class="sr-only">Edit</span>
                                </th>
                                <th></th>
                            </tr>
                            </thead>
                            <tbody class="odd:bg-indigo-400 even:bg-white">
                            @foreach($providersList as $user)
                                <tr class="odd:bg-indigo-50 even:bg-white hover:bg-indigo-100 bg-white border-b dark:bg-gray-800 dark:border-gray-700">
                                    <th scope="row"
                                        class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                        {{ $user->name }}
                                    </th>
                                    <td class="px-6 py-4">
                                        {{ $user->phone_number }}
                                    </td>
                                    <td class="px-6 py-4">
                                        {{ $user->email }}
                                    </td>
                                    <td class="px-6 py-4">
                                        {{ strtoupper($user->role) }}
                                    </td>
                                    <td class="px-6 py-4">
                                        {{ strtoupper($user->earnings) }} MKD
                                    </td>
                                    <td class="px-6 py-4">
                                        {{ strtoupper($user->ratings) }} stars
                                    </td>
                                    <td class="px-6 py-4 text-right">
                                        <a href="/admin?activeLink=providers&panelAction=providerDetails&driverId={{ $user->driver_id }}"
                                           class="font-medium text-blue-600 dark:text-blue-500 hover:underline">View
                                            details</a>
                                    </td>
                                    <td class="px-6 py-4 text-right">
                                        <form method="POST" action="/admin/providers/{{$user->driver_id}}">
                                            {{ csrf_field() }}
                                            {{ method_field('DELETE') }}

                                            <div class="form-group">
                                                <button type="submit" class="text-red-600">
                                                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"
                                                         fill="currentColor" class="size-6">
                                                        <path fill-rule="evenodd"
                                                              d="M12 2.25c-5.385 0-9.75 4.365-9.75 9.75s4.365 9.75 9.75 9.75 9.75-4.365 9.75-9.75S17.385 2.25 12 2.25Zm-1.72 6.97a.75.75 0 1 0-1.06 1.06L10.94 12l-1.72 1.72a.75.75 0 1 0 1.06 1.06L12 13.06l1.72 1.72a.75.75 0 1 0 1.06-1.06L13.06 12l1.72-1.72a.75.75 0 1 0-1.06-1.06L12 10.94l-1.72-1.72Z"
                                                              clip-rule="evenodd"/>
                                                    </svg>
                                                </button>
                                            </div>
                                        </form>
                                    </td>
                                </tr>
                            @endforeach

                            </tbody>
                        </table>
                    </div>

                    <div class="mt-3">
                        {{ $providersList->links() }}
                    </div>

                @endif

                    @if(Request::get('activeLink') == 'providers' && Request::get('panelAction') == 'providersByType')

                        <div class="mt-16 relative overflow-x-auto shadow-md sm:rounded-lg">
                            <table class="border w-full text-sm text-left rtl:text-right text-gray-500 dark:text-gray-400">
                                <caption
                                    class="p-5 text-lg font-semibold text-left rtl:text-right text-gray-900 bg-white dark:text-white dark:bg-gray-800">
                                    {{ str_replace('_',' ', ucwords(Request::get('providerType'))) }}s
                                    <p class="mt-1 text-sm font-normal text-gray-500 dark:text-gray-400">A list of the
                                        providers in the database including information for a given type.</p>
                                </caption>
                                <thead
                                    class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
                                <tr>
                                    <th scope="col" class="px-6 py-3">
                                        Name
                                    </th>
                                    <th scope="col" class="px-6 py-3">
                                        Phone number
                                    </th>
                                    <th scope="col" class="px-6 py-3">
                                        Email
                                    </th>
                                    <th scope="col" class="px-6 py-3">
                                        Type of provider
                                    </th>
                                    <th scope="col" class="px-6 py-3">
                                        Earnings
                                    </th>
                                    <th scope="col" class="px-6 py-3">
                                        Rating
                                    </th>
                                    <th scope="col" class="px-6 py-3">
                                        <span class="sr-only">Edit</span>
                                    </th>
                                    <th></th>
                                </tr>
                                </thead>
                                <tbody class="odd:bg-indigo-400 even:bg-white">
                                @foreach($providersList as $user)
                                    <tr class="odd:bg-indigo-50 even:bg-white hover:bg-indigo-100 bg-white border-b dark:bg-gray-800 dark:border-gray-700">
                                        <th scope="row"
                                            class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                            {{ $user->name }}
                                        </th>
                                        <td class="px-6 py-4">
                                            {{ $user->phone_number }}
                                        </td>
                                        <td class="px-6 py-4">
                                            {{ $user->email }}
                                        </td>
                                        <td class="px-6 py-4">
                                            {{ strtoupper($user->role) }}
                                        </td>
                                        <td class="px-6 py-4">
                                            {{ strtoupper($user->earnings) }} MKD
                                        </td>
                                        <td class="px-6 py-4">
                                            {{ strtoupper($user->ratings) }} stars
                                        </td>
                                        <td class="px-6 py-4 text-right">
                                            <a href="/admin?activeLink=providers&panelAction=providerDetails&driverId={{ $user->driver_id }}"
                                               class="font-medium text-blue-600 dark:text-blue-500 hover:underline">View
                                                details</a>
                                        </td>
                                        <td class="px-6 py-4 text-right">
                                            <form method="POST" action="/admin/providers/{{$user->driver_id}}">
                                                {{ csrf_field() }}
                                                {{ method_field('DELETE') }}

                                                <div class="form-group">
                                                    <button type="submit" class="text-red-600">
                                                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"
                                                             fill="currentColor" class="size-6">
                                                            <path fill-rule="evenodd"
                                                                  d="M12 2.25c-5.385 0-9.75 4.365-9.75 9.75s4.365 9.75 9.75 9.75 9.75-4.365 9.75-9.75S17.385 2.25 12 2.25Zm-1.72 6.97a.75.75 0 1 0-1.06 1.06L10.94 12l-1.72 1.72a.75.75 0 1 0 1.06 1.06L12 13.06l1.72 1.72a.75.75 0 1 0 1.06-1.06L13.06 12l1.72-1.72a.75.75 0 1 0-1.06-1.06L12 10.94l-1.72-1.72Z"
                                                                  clip-rule="evenodd"/>
                                                        </svg>
                                                    </button>
                                                </div>
                                            </form>
                                        </td>
                                    </tr>
                                @endforeach

                                </tbody>
                            </table>
                        </div>

                        <div class="mt-3">
                            {{ $providersList->links() }}
                        </div>

                    @endif


                @if(Request::get('activeLink') == 'rideRequests' && Request::get('panelAction') == 'allRideRequests')

                    <div class="mt-16 relative overflow-x-auto shadow-md sm:rounded-lg">
                        <table class="border w-full text-sm text-left rtl:text-right text-gray-500 dark:text-gray-400">
                            <caption
                                class="p-5 text-lg font-semibold text-left rtl:text-right text-gray-900 bg-white dark:text-white dark:bg-gray-800">
                                Ride Requests
                                <p class="mt-1 text-sm font-normal text-gray-500 dark:text-gray-400">A list of all the
                                    ride requests in the database including non active ones.</p>
                            </caption>
                            <thead
                                class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
                            <tr>
                                <th scope="col" class="px-6 py-3">
                                    Rider Name
                                </th>
                                <th scope="col" class="px-6 py-3">
                                    Rider Phone number
                                </th>
                                <th scope="col" class="px-6 py-3">
                                    Driver
                                </th>
                                <th scope="col" class="px-6 py-3">
                                    Status of request
                                </th>
                                <th scope="col" class="px-6 py-3">
                                    Date Requested
                                </th>
                                <th scope="col" class="px-6 py-3">
                                    <span class="sr-only">Cancel</span>
                                </th>
                                <th></th>
                            </tr>
                            </thead>
                            <tbody class="odd:bg-indigo-400 even:bg-white">
                            @foreach($rideRequestsList as $rideRequest)
                                <tr class="odd:bg-indigo-50 even:bg-white hover:bg-indigo-100 bg-white border-b dark:bg-gray-800 dark:border-gray-700">
                                    <th scope="row"
                                        class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                        {{ $rideRequest->rider_name }}
                                    </th>
                                    <td class="px-6 py-4">
                                        {{ $rideRequest->rider_phone }}
                                    </td>
                                    <td class="px-6 py-4">
                                        @if($rideRequest->driver_id == "waiting")
                                            {{ $rideRequest->driver_id }}
                                        @else
                                            {{ $rideRequest->driver_name }}
                                        @endif
                                    </td>
                                    <td class="px-6 py-4">
                                        @if(strtoupper($rideRequest->status) == null)
                                            <span
                                                class="inline-flex items-center gap-x-1.5 py-1.5 px-3 rounded-lg text-xs font-medium bg-gray-200 text-gray-800 dark:bg-white/10 dark:text-white">WAITING FOR DRIVER</span>
                                        @elseif(strtoupper($rideRequest->status) == 'FINISHED')
                                            <span
                                                class="inline-flex items-center gap-x-1.5 py-1.5 px-3 rounded-lg text-xs font-medium bg-green-200 text-gray-800 dark:bg-white/10 dark:text-white">{{ strtoupper($rideRequest->status) }}</span>
                                        @elseif(strtoupper($rideRequest->status) == 'ACCEPTED')
                                            <span
                                                class="inline-flex items-center gap-x-1.5 py-1.5 px-3 rounded-lg text-xs font-medium bg-blue-200 text-gray-800 dark:bg-white/10 dark:text-white">{{ strtoupper($rideRequest->status) }}</span>
                                        @elseif(strtoupper($rideRequest->status) == 'ARRIVED')
                                            <span
                                                class="inline-flex items-center gap-x-1.5 py-1.5 px-3 rounded-lg text-xs font-medium bg-yellow-200 text-gray-800 dark:bg-white/10 dark:text-white">{{ strtoupper($rideRequest->status) }}</span>
                                        @endif
                                    </td>
                                    <td class="px-6 py-4">
                                        {{ $rideRequest->created_at }}
                                    </td>
                                    <td class="px-6 py-4 text-right">
                                        <form method="POST" action="/admin/ride-requests/{{$rideRequest->id}}">
                                            {{ csrf_field() }}
                                            {{ method_field('DELETE') }}

                                            <div class="form-group">
                                                @if(strtoupper($rideRequest->status) == 'FINISHED')
                                                    <button type="submit"
                                                            class="py-2 px-4 inline-flex items-center gap-x-2 text-sm font-medium rounded-lg border border-gray-200 bg-white text-red-500 shadow-sm hover:bg-gray-50 disabled:opacity-50 disabled:pointer-events-none dark:bg-neutral-900 dark:border-neutral-700 dark:hover:bg-neutral-800">
                                                        Cancel ride
                                                    </button>
                                                @else
                                                    <button type="submit"
                                                            class="py-2 px-4 inline-flex items-center gap-x-2 text-sm font-medium rounded-lg border border-gray-200 bg-white text-gray-500 shadow-sm hover:bg-gray-50 disabled:opacity-50 disabled:pointer-events-none dark:bg-neutral-900 dark:border-neutral-700 dark:hover:bg-neutral-800"
                                                            disabled>
                                                        Cancel ride
                                                    </button>
                                                @endif
                                            </div>
                                        </form>
                                    </td>
                                </tr>
                            @endforeach

                            </tbody>
                        </table>
                    </div>

                    <div class="mt-3">
                        {{ $rideRequestsList->links() }}
                    </div>

                @endif


                @if(Request::get('activeLink') == 'providers' && Request::get('panelAction') == 'providerDetails')

                    @include('admin.provider-details')
                @endif

            </div>

        </div>
    </x-slot>

    {{--        <!-- Component Start -->--}}
    {{--        <div class="bg-white flex flex-col items-center w-40 h-full overflow-hidden text-gray-700 rounded">--}}
    {{--            <a class="flex items-center w-full px-3 mt-3" href="#">--}}
    {{--                <svg class="w-8 h-8 fill-current" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">--}}
    {{--                    <path d="M11 17a1 1 0 001.447.894l4-2A1 1 0 0017 15V9.236a1 1 0 00-1.447-.894l-4 2a1 1 0 00-.553.894V17zM15.211 6.276a1 1 0 000-1.788l-4.764-2.382a1 1 0 00-.894 0L4.789 4.488a1 1 0 000 1.788l4.764 2.382a1 1 0 00.894 0l4.764-2.382zM4.447 8.342A1 1 0 003 9.236V15a1 1 0 00.553.894l4 2A1 1 0 009 17v-5.764a1 1 0 00-.553-.894l-4-2z" />--}}
    {{--                </svg>--}}
    {{--                <span class="ml-2 text-sm font-bold">The App</span>--}}
    {{--            </a>--}}
    {{--            <div class="w-full px-2">--}}
    {{--                <div class="flex flex-col items-center w-full mt-3 border-t border-gray-300">--}}
    {{--                    <a class="flex items-center w-full h-12 px-3 mt-2 rounded hover:bg-gray-300" href="#">--}}
    {{--                        <svg class="w-6 h-6 stroke-current" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">--}}
    {{--                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6" />--}}
    {{--                        </svg>--}}
    {{--                        <span class="ml-2 text-sm font-medium">Dasboard</span>--}}
    {{--                    </a>--}}
    {{--                    <a class="flex items-center w-full h-12 px-3 mt-2 rounded hover:bg-gray-300" href="#">--}}
    {{--                        <svg class="w-6 h-6 stroke-current" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">--}}
    {{--                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />--}}
    {{--                        </svg>--}}
    {{--                        <span class="ml-2 text-sm font-medium">Search</span>--}}
    {{--                    </a>--}}
    {{--                    <a class="flex items-center w-full h-12 px-3 mt-2 bg-gray-300 rounded" href="#">--}}
    {{--                        <svg class="w-6 h-6 stroke-current" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">--}}
    {{--                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 8v8m-4-5v5m-4-2v2m-2 4h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z" />--}}
    {{--                        </svg>--}}
    {{--                        <span class="ml-2 text-sm font-medium">Insights</span>--}}
    {{--                    </a>--}}
    {{--                    <a class="flex items-center w-full h-12 px-3 mt-2 rounded hover:bg-gray-300" href="#">--}}
    {{--                        <svg class="w-6 h-6 stroke-current" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">--}}
    {{--                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7v8a2 2 0 002 2h6M8 7V5a2 2 0 012-2h4.586a1 1 0 01.707.293l4.414 4.414a1 1 0 01.293.707V15a2 2 0 01-2 2h-2M8 7H6a2 2 0 00-2 2v10a2 2 0 002 2h8a2 2 0 002-2v-2" />--}}
    {{--                        </svg>--}}
    {{--                        <span class="ml-2 text-sm font-medium">Docs</span>--}}
    {{--                    </a>--}}
    {{--                </div>--}}
    {{--                <div class="flex flex-col items-center w-full mt-2 border-t border-gray-300">--}}
    {{--                    <a class="flex items-center w-full h-12 px-3 mt-2 rounded hover:bg-gray-300" href="#">--}}
    {{--                        <svg class="w-6 h-6 stroke-current" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">--}}
    {{--                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13L5.4 5M7 13l-2.293 2.293c-.63.63-.184 1.707.707 1.707H17m0 0a2 2 0 100 4 2 2 0 000-4zm-8 2a2 2 0 11-4 0 2 2 0 014 0z" />--}}
    {{--                        </svg>--}}
    {{--                        <span class="ml-2 text-sm font-medium">Products</span>--}}
    {{--                    </a>--}}
    {{--                    <a class="flex items-center w-full h-12 px-3 mt-2 rounded hover:bg-gray-300" href="#">--}}
    {{--                        <svg class="w-6 h-6 stroke-current"  xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">--}}
    {{--                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6V4m0 2a2 2 0 100 4m0-4a2 2 0 110 4m-6 8a2 2 0 100-4m0 4a2 2 0 110-4m0 4v2m0-6V4m6 6v10m6-2a2 2 0 100-4m0 4a2 2 0 110-4m0 4v2m0-6V4" />--}}
    {{--                        </svg>--}}
    {{--                        <span class="ml-2 text-sm font-medium">Settings</span>--}}
    {{--                    </a>--}}
    {{--                    <a class="relative flex items-center w-full h-12 px-3 mt-2 rounded hover:bg-gray-300" href="#">--}}
    {{--                        <svg class="w-6 h-6 stroke-current" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">--}}
    {{--                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 8h10M7 12h4m1 8l-4-4H5a2 2 0 01-2-2V6a2 2 0 012-2h14a2 2 0 012 2v8a2 2 0 01-2 2h-3l-4 4z" />--}}
    {{--                        </svg>--}}
    {{--                        <span class="ml-2 text-sm font-medium">Messages</span>--}}
    {{--                        <span class="absolute top-0 left-0 w-2 h-2 mt-2 ml-2 bg-indigo-500 rounded-full"></span>--}}
    {{--                    </a>--}}
    {{--                </div>--}}
    {{--            </div>--}}
    {{--            <a class="flex items-center justify-center w-full h-16 mt-auto bg-gray-200 hover:bg-gray-300" href="#">--}}
    {{--                <svg class="w-6 h-6 stroke-current" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">--}}
    {{--                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5.121 17.804A13.937 13.937 0 0112 16c2.5 0 4.847.655 6.879 1.804M15 10a3 3 0 11-6 0 3 3 0 016 0zm6 2a9 9 0 11-18 0 9 9 0 0118 0z" />--}}
    {{--                </svg>--}}
    {{--                <span class="ml-2 text-sm font-medium">Account</span>--}}
    {{--            </a>--}}
    {{--        </div>--}}
    {{--        <!-- Component End  -->--}}

    @if($activeLink == 'dashboard')


    @push('scripts')
        <script>
            const data = {
                labels: @json($users->map(fn ($users) => $users->date)),
                datasets: [{
                    label: 'Registered users in the last 30 days',
                    backgroundColor: 'rgba(31,112,112,0.3)',
                    borderColor: 'rgb(9,140,130)',
                    data: @json($users->map(fn ($users) => $users->aggregate)),
                }]
            };
            const config = {
                type: 'line',
                data: data
            };
            const myChart = new Chart(
                document.getElementById('myChart'),
                config
            );

            const dataRideRequests = {
                labels: @json($rideRequestsByDate->map(fn ($rideRequestsByDate) => $rideRequestsByDate->date)),
                datasets: [{
                    label: 'Requested rides in the last 30 days',
                    backgroundColor: 'rgba(31,112,112,0.3)',
                    borderColor: 'rgb(9,140,130)',
                    data: @json($rideRequestsByDate->map(fn ($rideRequestsByDate) => $rideRequestsByDate->aggregate)),
                }]
            };
            const configRideRequests = {
                type: 'bar',
                data: dataRideRequests
            };
            const myChartRideRequests = new Chart(
                document.getElementById('rideRequestsNumChart'),
                configRideRequests
            );


            const dataTypes = {
                labels: [
                    'Regular Drivers',
                    'Taxi Drivers',
                    'Transporting Providers',
                ],
                datasets: [{
                    label: 'Distribution of providers by type',
                    data: @json($providersByType->map(fn ($providersByType) => $providersByType->count)),
                    backgroundColor: [
                        'rgb(9,140,130)',
                        'rgb(54, 162, 235)',
                        'rgb(255,182,86)',
                    ],
                    hoverOffset: 3,
                }],
            };
            const configTypes = {
                type: 'pie',
                data: dataTypes,
            };
            const myChartTypes = new Chart(
                document.getElementById('providersTypeDistributionChart'),
                configTypes
            );
        </script>
    @endpush
    @endif
</x-app-layout>


{{--<div class="grid grid-cols-1 md:grid-cols-2 gap-6 lg:gap-8">--}}
{{--    <a href="https://laravel.com/docs" class="scale-100 p-6 bg-white from-gray-700/50 via-transparent rounded-lg shadow-2xl shadow-gray-500/20 flex motion-safe:hover:scale-[1.01] transition-all duration-250 focus:outline focus:outline-2 focus:outline-red-500">--}}
{{--        <div>--}}
{{--            <div class="h-16 w-16 bg-red-50 flex items-center justify-center rounded-full">--}}
{{--                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" class="w-7 h-7 stroke-red-500">--}}
{{--                    <path stroke-linecap="round" stroke-linejoin="round" d="M12 6.042A8.967 8.967 0 006 3.75c-1.052 0-2.062.18-3 .512v14.25A8.987 8.987 0 016 18c2.305 0 4.408.867 6 2.292m0-14.25a8.966 8.966 0 016-2.292c1.052 0 2.062.18 3 .512v14.25A8.987 8.987 0 0018 18a8.967 8.967 0 00-6 2.292m0-14.25v14.25"></path>--}}
{{--                </svg>--}}
{{--            </div>--}}

{{--            <h2 class="mt-6 text-xl font-semibold text-gray-900">Documentation</h2>--}}

{{--            <p class="mt-4 text-gray-500 text-sm leading-relaxed">--}}
{{--                Laravel has wonderful documentation covering every aspect of the framework. Whether you are a newcomer or have prior experience with Laravel, we recommend reading our documentation from beginning to end.--}}
{{--            </p>--}}
{{--        </div>--}}

{{--        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" class="self-center shrink-0 stroke-red-500 w-6 h-6 mx-6">--}}
{{--            <path stroke-linecap="round" stroke-linejoin="round" d="M4.5 12h15m0 0l-6.75-6.75M19.5 12l-6.75 6.75"></path>--}}
{{--        </svg>--}}
{{--    </a>--}}

{{--    <a href="https://laracasts.com" class="scale-100 p-6 bg-white from-gray-700/50 via-transparent rounded-lg shadow-2xl shadow-gray-500/20 flex motion-safe:hover:scale-[1.01] transition-all duration-250 focus:outline focus:outline-2 focus:outline-red-500">--}}
{{--        <div>--}}
{{--            <div class="h-16 w-16 bg-red-50 flex items-center justify-center rounded-full">--}}
{{--                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" class="w-7 h-7 stroke-red-500">--}}
{{--                    <path stroke-linecap="round" d="M15.75 10.5l4.72-4.72a.75.75 0 011.28.53v11.38a.75.75 0 01-1.28.53l-4.72-4.72M4.5 18.75h9a2.25 2.25 0 002.25-2.25v-9a2.25 2.25 0 00-2.25-2.25h-9A2.25 2.25 0 002.25 7.5v9a2.25 2.25 0 002.25 2.25z"></path>--}}
{{--                </svg>--}}
{{--            </div>--}}

{{--            <h2 class="mt-6 text-xl font-semibold text-gray-900">Laracasts</h2>--}}

{{--            <p class="mt-4 text-gray-500 text-sm leading-relaxed">--}}
{{--                Laracasts offers thousands of video tutorials on Laravel, PHP, and JavaScript development. Check them out, see for yourself, and massively level up your development skills in the process.--}}
{{--            </p>--}}
{{--        </div>--}}

{{--        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" class="self-center shrink-0 stroke-red-500 w-6 h-6 mx-6">--}}
{{--            <path stroke-linecap="round" stroke-linejoin="round" d="M4.5 12h15m0 0l-6.75-6.75M19.5 12l-6.75 6.75"></path>--}}
{{--        </svg>--}}
{{--    </a>--}}

{{--    <a href="https://laravel-news.com" class="scale-100 p-6 bg-white from-gray-700/50 via-transparent rounded-lg shadow-2xl shadow-gray-500/20 flex motion-safe:hover:scale-[1.01] transition-all duration-250 focus:outline focus:outline-2 focus:outline-red-500">--}}
{{--        <div>--}}
{{--            <div class="h-16 w-16 bg-red-50 flex items-center justify-center rounded-full">--}}
{{--                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" class="w-7 h-7 stroke-red-500">--}}
{{--                    <path stroke-linecap="round" stroke-linejoin="round" d="M12 7.5h1.5m-1.5 3h1.5m-7.5 3h7.5m-7.5 3h7.5m3-9h3.375c.621 0 1.125.504 1.125 1.125V18a2.25 2.25 0 01-2.25 2.25M16.5 7.5V18a2.25 2.25 0 002.25 2.25M16.5 7.5V4.875c0-.621-.504-1.125-1.125-1.125H4.125C3.504 3.75 3 4.254 3 4.875V18a2.25 2.25 0 002.25 2.25h13.5M6 7.5h3v3H6v-3z"></path>--}}
{{--                </svg>--}}
{{--            </div>--}}

{{--            <h2 class="mt-6 text-xl font-semibold text-gray-900">Laravel News</h2>--}}

{{--            <p class="mt-4 text-gray-500 text-sm leading-relaxed">--}}
{{--                Laravel News is a community driven portal and newsletter aggregating all of the latest and most important news in the Laravel ecosystem, including new package releases and tutorials.--}}
{{--            </p>--}}
{{--        </div>--}}

{{--        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" class="self-center shrink-0 stroke-red-500 w-6 h-6 mx-6">--}}
{{--            <path stroke-linecap="round" stroke-linejoin="round" d="M4.5 12h15m0 0l-6.75-6.75M19.5 12l-6.75 6.75"></path>--}}
{{--        </svg>--}}
{{--    </a>--}}

{{--    <div class="scale-100 p-6 bg-white from-gray-700/50 via-transparent rounded-lg shadow-2xl shadow-gray-500/20 flex motion-safe:hover:scale-[1.01] transition-all duration-250 focus:outline focus:outline-2 focus:outline-red-500">--}}
{{--        <div>--}}
{{--            <div class="h-16 w-16 bg-red-50 flex items-center justify-center rounded-full">--}}
{{--                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" class="w-7 h-7 stroke-red-500">--}}
{{--                    <path stroke-linecap="round" stroke-linejoin="round" d="M6.115 5.19l.319 1.913A6 6 0 008.11 10.36L9.75 12l-.387.775c-.217.433-.132.956.21 1.298l1.348 1.348c.21.21.329.497.329.795v1.089c0 .426.24.815.622 1.006l.153.076c.433.217.956.132 1.298-.21l.723-.723a8.7 8.7 0 002.288-4.042 1.087 1.087 0 00-.358-1.099l-1.33-1.108c-.251-.21-.582-.299-.905-.245l-1.17.195a1.125 1.125 0 01-.98-.314l-.295-.295a1.125 1.125 0 010-1.591l.13-.132a1.125 1.125 0 011.3-.21l.603.302a.809.809 0 001.086-1.086L14.25 7.5l1.256-.837a4.5 4.5 0 001.528-1.732l.146-.292M6.115 5.19A9 9 0 1017.18 4.64M6.115 5.19A8.965 8.965 0 0112 3c1.929 0 3.716.607 5.18 1.64"></path>--}}
{{--                </svg>--}}
{{--            </div>--}}

{{--            <h2 class="mt-6 text-xl font-semibold text-gray-900">Vibrant Ecosystem</h2>--}}

{{--            <p class="mt-4 text-gray-500 text-sm leading-relaxed">--}}
{{--                Laravel's robust library of first-party tools and libraries, such as <a href="https://forge.laravel.com" class="underline hover:text-gray-700 focus:outline focus:outline-2 focus:rounded-sm focus:outline-red-500">Forge</a>, <a href="https://vapor.laravel.com" class="underline hover:text-gray-700 focus:outline focus:outline-2 focus:rounded-sm focus:outline-red-500">Vapor</a>, <a href="https://nova.laravel.com" class="underline hover:text-gray-700 focus:outline focus:outline-2 focus:rounded-sm focus:outline-red-500">Nova</a>, and <a href="https://envoyer.io" class="underline hover:text-gray-700 focus:outline focus:outline-2 focus:rounded-sm focus:outline-red-500">Envoyer</a> help you take your projects to the next level. Pair them with powerful open source libraries like <a href="https://laravel.com/docs/billing" class="underline hover:text-gray-700 focus:outline focus:outline-2 focus:rounded-sm focus:outline-red-500">Cashier</a>, <a href="https://laravel.com/docs/dusk" class="underline hover:text-gray-700 focus:outline focus:outline-2 focus:rounded-sm focus:outline-red-500">Dusk</a>, <a href="https://laravel.com/docs/broadcasting" class="underline hover:text-gray-700 focus:outline focus:outline-2 focus:rounded-sm focus:outline-red-500">Echo</a>, <a href="https://laravel.com/docs/horizon" class="underline hover:text-gray-700 focus:outline focus:outline-2 focus:rounded-sm focus:outline-red-500">Horizon</a>, <a href="https://laravel.com/docs/sanctum" class="underline hover:text-gray-700 focus:outline focus:outline-2 focus:rounded-sm focus:outline-red-500">Sanctum</a>, <a href="https://laravel.com/docs/telescope" class="underline hover:text-gray-700 focus:outline focus:outline-2 focus:rounded-sm focus:outline-red-500">Telescope</a>, and more.--}}
{{--            </p>--}}
{{--        </div>--}}
{{--    </div>--}}
{{--</div>--}}

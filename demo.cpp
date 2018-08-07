#include "jbms/openssl/rand.hpp"
#include "jbms/binary_elliptic_curve/GLS254.hpp"
#include "jbms/multiset_hash/ECMH.hpp"
#include "jbms/hash/blake2b.hpp"
#include "jbms/multiset_hash/MuHash.hpp"
#include <iostream>
#include <string>
#include <vector>
using namespace std;

int main()
{
  using Curve = jbms::binary_elliptic_curve::GLS254;
  using Hash = jbms::hash::blake2b;
  using ECMH = jbms::multiset_hash::ECMH<Curve, Hash, false>;
  using State = ECMH::State;
  //using initial_state = jbms::multiset_hash::initial_state<ECMH, true>;
  using namespace jbms;

  vector<array<uint8_t, 5>> arr={{1,2,3,4,5},{2,2,3,4,5}};

  ECMH ecmh;
  State I = initial_state(ecmh);
  
  State a = I;
  add(ecmh, a, arr[0]);
  add(ecmh, a, arr[1]);
  cout << "a=" << to_hex(ecmh, a) << endl;

  State b = I;
  add(ecmh, b, arr[0]);
  State d = I;
  add(ecmh, d, arr[1]);
  add_hash(ecmh, b, d);

  using array_view = jbms::array_view<uint8_t>;
  State c = I;
  array<uint8_t,10> arr1{1,2,3,4,5, 2,2,3,4,5};
  add(ecmh, c, array_view(arr1.begin(), 10));
  //add(ecmh, c, array_view(arr1.begin()+5, 5));

  cout << "a=" << to_hex(ecmh, a) << endl;
  cout << "b=" << to_hex(ecmh, b) << endl;
  cout << "c=" << to_hex(ecmh, c) << endl;
  cout << "d=" << to_hex(ecmh, d) << endl;

  //jbms::multiset_hash::benchmark_muhash(num_bits, Hash());
}




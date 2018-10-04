{-# LANGUAGE CPP #-}
{-# LANGUAGE MagicHash #-}

#if HAVE_QUANTIFIED_CONSTRAINTS
{-# LANGUAGE QuantifiedConstraints #-}
#endif

module Test.QuickCheck.Classes.Compat
  ( isTrue#
#if HAVE_UNARY_LAWS
  , eq1
#endif
#if HAVE_BINARY_LAWS
  , eq2
#endif
  ) where

#if MIN_VERSION_base(4,7,0)
import GHC.Exts (isTrue#)
#endif

#if defined(HAVE_UNARY_LAWS) || defined(HAVE_BINARY_LAWS)
import qualified Data.Functor.Classes as C
#endif

#if !MIN_VERSION_base(4,7,0)
isTrue# :: Bool -> Bool
isTrue# b = b
#endif

#if HAVE_UNARY_LAWS
#if HAVE_QUANTIFIED_CONSTRAINTS
eq1 :: (forall a. Eq a => Eq (f a), Eq a) => f a -> f a -> Bool
eq1 = (==)
#else
eq1 :: (C.Eq1 f, Eq a) => f a -> f a -> Bool
eq1 = C.eq1
#endif
#endif

#if HAVE_BINARY_LAWS
#if HAVE_QUANTIFIED_CONSTRAINTS
eq2 :: (forall a. (Eq a, Eq b) => Eq (f a b), Eq a, Eq b) => f a b -> f a b -> Bool
eq2 = (==)
#else
eq2 :: (C.Eq2 f, Eq a, Eq b) => f a b -> f a b -> Bool
eq2 = C.eq2
#endif
#endif

